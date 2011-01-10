 #
 #  @Authors:    
 #      Brizuela Lucia                  lula.brizuela@gmail.com
 #      Guerra Brenda                   brenda.guerra.7@gmail.com
 #      Crosa Fernando                  fernandocrosa@hotmail.com
 #      Branciforte Horacio             horaciob@gmail.com
 #      Luna Juan                       juancluna@gmail.com
 #      
 #  @copyright (C) 2010 MercadoLibre S.R.L
 #
 #
 #  @license        GNU/GPL, see license.txt
 #  This program is free software: you can redistribute it and/or modify
 #  it under the terms of the GNU General Public License as published by
 #  the Free Software Foundation, either version 3 of the License, or
 #  (at your option) any later version.
 #
 #  This program is distributed in the hope that it will be useful,
 #  but WITHOUT ANY WARRANTY; without even the implied warranty of
 #  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 #  GNU General Public License for more details.
 #
 #  You should have received a copy of the GNU General Public License
 #  along with this program.  If not, see http://www.gnu.org/licenses/.
 #


class QueueObserversController < ApplicationController

  def quick_view
    @queues_value=QueueObserver.run
    render :partial => "show"
  end
  
  
  def index
    permit "root" do
      queue=QueueObserver.new
      @running=queue.get_running_info
      #@tasks=[]
      @tasks=queue.get_named_tasks
    end
  end


  def delete
    permit "root" do
      queue=QueueObserver.new
      queue.delete_execution(params[:id].to_i)
      redirect_to :action=>:index
    end
  end


  def refresh 
    permit "root" do
      QueueObserver.refresh_workers
      redirect_to :controller => "queue_observers", :action => "index"
    end
  end
end
