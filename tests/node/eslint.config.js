import eslintConfigPrettier from "eslint-config-prettier";
import eslintPluginPrettierRecommended from "eslint-plugin-prettier/recommended";

export default [
	eslintPluginPrettierRecommended,
	eslintConfigPrettier,
	{
		rules: {
			quotes: [
				"error",
				"double",
				{ avoidEscape: true, allowTemplateLiterals: false },
			],
			semi: "error",
			"prefer-const": "error",
			indent: ["error", "tab"],
			"prettier/prettier": [
				"error",
				{
					trailingComma: "es5",
					tabWidth: 2,
					semi: true,
					singleQuote: false,
					useTabs: true,
				},
			],
		},
	},
];
