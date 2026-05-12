local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node

require("luasnip.loaders.from_vscode").lazy_load()

-- Fabric Mixin snippets for Java.
ls.add_snippets("java", {
    s("mixin", {
        t("@Mixin("), i(1, "TargetClass"), t({".class)", ""}),
        t("public abstract class "), i(2, "TargetClassName"), t({"Mixin {", "    "}),
        i(0),
        t({"", "}"}),
    }),

    s("inject", {
        t("@Inject(method = \""), i(1, "targetMethod"), t("\", at = @At(\""),
        c(2, { t("HEAD"), t("TAIL"), t("RETURN") }),
        t({"\"))", ""}),
        t("private void "), i(3, "injectedMethod"), t("("),
        i(4, "CallbackInfo ci"),
        t({") {", "    "}),
        i(0),
        t({"", "}"}),
    }),

    s("redirect", {
        t("@Redirect(method = \""), i(1, "targetMethod"), t("\", at = @At(value = \"INVOKE\", target = \""),
        i(2, "Lnet/minecraft/class;method()V"),
        t({"\"))", ""}),
        t("private "), i(3, "ReturnType"), t(" "), i(4, "redirectMethod"), t("("),
        i(5),
        t({") {", "    "}),
        i(0),
        t({"", "}"}),
    }),

    s("modifyvar", {
        t("@ModifyVariable(method = \""), i(1, "targetMethod"), t("\", at = @At(\""),
        c(2, { t("HEAD"), t("STORE"), t("LOAD") }),
        t("\"), ordinal = "), i(3, "0"),
        t({")", ""}),
        t("private "), i(4, "Type"), t(" "), i(5, "modifyVar"), t("("),
        i(6, "Type value"),
        t({") {", "    "}),
        i(0),
        t({"", "}"}),
    }),

    s("shadow", {
        t("@Shadow"), t({"", ""}),
        c(1, {
            { t("private "), i(1, "Type"), t(" "), i(2, "fieldName"), t(";") },
            { t("protected abstract "), i(1, "ReturnType"), t(" "), i(2, "methodName"), t("("), i(3), t(");") },
        }),
    }),
})
