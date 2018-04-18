/**
     * 
     * @param word palabra a analizar
     * @param p es la posicion en la que vamos en la palabra
     * @param actual es el estado Actual
     * @param route es el recorrido hecho hasta el momento por ese autómata
     */
    private void recorrerAutomata(String word, int p, String actual, String route) {
        
        String nextStates;
        
        if( p == word.length() ) {
            
            boolean flag=false;
            for ( int i=0; i < automata.getAceptedStates().length; i++ ) {
                if ( actual.equals( automata.getAceptedStates()[i] ) ) {
                    flag = true;
                }
            }
            
            if( flag ) {
                System.out.println("\n\tCadena valida");
                validRoutes++;
                FileUtil.Writting(route,FINALROUTES);
            } else {
                System.out.println("\n\tCadena no valida");
            }
            
            System.out.println("\n\tRecorrido: "+route);
            
        } else {
            
            System.out.print("\n\tSimbolo: " + word.charAt(p) + "\n\tEn posicion: "+ p);
            System.out.print("\n\tEstado Actual: "+actual);
            nextStates = checkNextState(actual, ""+word.charAt(p), automata.getRules());
            p++;
            imprimirEstados(nextStates);
            for(int i=0;i<nextStates.length();i++) {
                recorrerAutomata ( word, p,
                                    "" + nextStates.charAt(i),
                                    route + nextStates.charAt(i));                
            }
        }
    }