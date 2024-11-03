// BrainWords

#include "Brainwords.hpp"

int main(int argc, char *argv[]) {
    arg(0, argv[0]);
    std::ostringstream cmdline;
    for (int i = 1; i < argc; i++) {
        arg(i, argv[i]);
        cmdline << argv[i] << ' ';
        yyfile = argv[i];
        assert(yyin = fopen(yyfile, "r"));
        yyparse();
        fclose(yyin);
        yyfile = nullptr;
    }
    return yystr(cmdline.str());
}

void arg(int argc, char *argv) {  //
    fprintf(stderr, "argv[%i] = <%s>\n", argc, argv);
}
