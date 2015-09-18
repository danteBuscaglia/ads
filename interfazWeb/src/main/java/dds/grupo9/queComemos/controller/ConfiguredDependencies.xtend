package dds.grupo9.queComemos.controller

import dds.grupo9.queComemos.repoUsuarios.RepoUsuarioEjemplo
import dds.grupo9.queComemos.repoRecetas.RepoRecetasEjemplo

class ConfiguredDependencies {
	public static val repoUsuarios = new RepoUsuarioEjemplo
	public static val repoRecetas = new RepoRecetasEjemplo
}