import eng_to_ipa as ipa
import webbrowser
from termcolor import colored
    
try:
    while True:
        f = input(colored('$ ', 'green'))
        resp = ipa.convert(f)
        print(colored("Em IPA a pronuncia correta seria: ", 'blue'), resp)
        print(colored("Você buscou pela palavra: {} ".format(f), 'magenta'))
    
        # Define as URLs dos sites de referência para a palavra pesquisada
        googleimage = "https://www.google.com/search?tbm=isch&q={}".format(f)
        taoeba = "https://tatoeba.org/pt-br/sentences/search?from=eng&query={}&to=por".format(f)
        wordreference = "https://www.wordreference.com/definition/{}".format(f)
        linguee = "https://www.linguee.com.br/portugues-ingles/search?source=ingles&query={}".format(f)
        forvo = "https://forvo.com/word/{}/#en_usa".format(f)
        cambridge = "https://dictionary.cambridge.org/pt/dicionario/ingles-portugues/{}".format(f)
        michaelis = "https://michaelis.uol.com.br/moderno-ingles/busca/ingles-portugues-moderno/{}".format(f)
        reverso = "https://www.reverso.net/tradu%C3%A7%C3%A3o-texto#sl=eng&tl=por&text={}".format(f)
        collins = "https://www.collinsdictionary.com/pt/dictionary/english/{}".format(f)
        translateuk = "https://translate.google.co.uk/?sl=en&tl=pt&text={}".format(f)
        oxford = "https://www.oxfordlearnersdictionaries.com/us/definition/english/{}".format(f)
        deepl = "https://www.deepl.com/translator#en/pt/{}".format(f)
    
        #webbrowser.open(linguee,new=2)
        #webbrowser.open(googleimage,new=2)
        webbrowser.open(michaelis,new=2)
        #webbrowser.open(forvo,new=2)
        #webbrowser.open(oxford,new=2)
        #webbrowser.open(reverso,new=2)
        #webbrowser.open(collins,new=2)
        webbrowser.open(cambridge,new=2)
        webbrowser.open(translateuk,new=2)
        webbrowser.open(taoeba,new=2)
        webbrowser.open(deepl,new=2)
        

except KeyboardInterrupt:
    print(colored("\r\n\r\nPrograma interrompido pelo usuário." ,"red"))
