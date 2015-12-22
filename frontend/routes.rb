ArchivesSpace::Application.routes.draw do

    match 'thesas/defaults' => 'thesas#defaults', :via => [:get]
    match 'thesas/defaults' => 'thesas#update_defaults', :via => [:post]
    resources :thesas
    match 'thesas/:id' => 'thesas#update', :via => [:post]
    match 'thesas/:id/delete' => 'thesas#delete', :via => [:post]

    match 'patron_stats/defaults' => 'patron_stats#defaults', :via => [:get]
    match 'patron_stats/defaults' => 'patron_stats#update_defaults', :via => [:post]
    resources :patron_stats
    match 'patron_stats/:id' => 'patron_stats#update', :via => [:post]
    match 'patron_stats/:id/delete' => 'patron_stats#delete', :via => [:post]
	
    match 'patron_regs/defaults' => 'patron_regs#defaults', :via => [:get]
    match 'patron_regs/defaults' => 'patron_regs#update_defaults', :via => [:post]
    resources :patron_regs
    match 'patron_regs/:id' => 'patron_regs#update', :via => [:post]
    match 'patron_regs/:id/delete' => 'patron_regs#delete', :via => [:post]
	
    match 'operations/defaults' => 'operations#defaults', :via => [:get]
    match 'operations/defaults' => 'operations#update_defaults', :via => [:post]
    resources :operations
    match 'operations/:id' => 'operations#update', :via => [:post]
    match 'operations/:id/delete' => 'operations#delete', :via => [:post]

    match 'ttuseas/defaults' => 'ttuseas#defaults', :via => [:get]
    match 'ttuseas/defaults' => 'ttuseas#update_defaults', :via => [:post]
    resources :ttuseas
    match 'ttuseas/:id' => 'ttuseas#update', :via => [:post]
    match 'ttuseas/:id/delete' => 'ttuseas#delete', :via => [:post]
	
	match 'reunions/defaults' => 'reunions#defaults', :via => [:get]
    match 'reunions/defaults' => 'reunions#update_defaults', :via => [:post]
    resources :reunions
    match 'reunions/:id' => 'reunions#update', :via => [:post]
    match 'reunions/:id/delete' => 'reunions#delete', :via => [:post]
	
	match 'vva_events/defaults' => 'vva_events#defaults', :via => [:get]
    match 'vva_events/defaults' => 'vva_events#update_defaults', :via => [:post]
    resources :vva_events
    match 'vva_events/:id' => 'vva_events#update', :via => [:post]
    match 'vva_events/:id/delete' => 'vva_events#delete', :via => [:post]
	
	match 'conferences/defaults' => 'conferences#defaults', :via => [:get]
    match 'conferences/defaults' => 'conferences#update_defaults', :via => [:post]
    resources :conferences
    match 'conferences/:id' => 'conferences#update', :via => [:post]
    match 'conferences/:id/delete' => 'conferences#delete', :via => [:post]
	
end
