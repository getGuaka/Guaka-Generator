//
//  File.swift
//  guaka-cli
//
//  Created by Omar Abdelhafith on 27/11/2016.
//
//

import Colorizer

public struct GuakaCliConfig {
  public static var dir: DirectoryType.Type = FileSystemDirectory.self
  public static var file: FileType.Type = FileSystemFile.self
}

public enum GuakaError: Error {
  case wrongDirectoryGiven(String)
  case triedToCreateProjectInNonEmptyDirectory(String)
  case failedCreatingFolder(String)
  case cannotCreateFile(String)
  case cannotReadFile(String)
  case setupFileAltered
  case notAGuakaProject
  case commandAlreadyExist(String, String)
  case missingCommandName
  case tooManyArgsPassed
  case wrongCommandNameFormat(String)

  public var error: String {
    switch self {
    case .wrongDirectoryGiven(let path):
      return [
        "Wrong path given:",
        "  \(path)",
        "The path must be an empty directory"
        ].joined(separator: "\n").f.Red

    case .triedToCreateProjectInNonEmptyDirectory(let path):
      return "Cannot create project in non empty directory: \(path)\n".f.Red

    case .failedCreatingFolder(let path):
      return "Failed creating directory \(path)".f.Red

    case .cannotCreateFile (let name):
      return "Cannot generate \(name) file".f.Red

    case .cannotReadFile(let path):
      return "Cannot read contents of file \(path)".f.Red

    case .setupFileAltered:
      return """
      Guaka setup.swift file has been altered.
      The placeholder used to insert commands cannot be found \(GeneratorParts.comamndAddingPlaceholder).
      You can try to add it yourself by updating `setup.swift` to look like

      \(GeneratorParts.setupFileContent())
      Adding command won't be possible."
      """.f.Red

    case .notAGuakaProject:
      return "This command can only be executed inside a Guaka project.".f.Red

    case .missingCommandName:
      return [
        "Missing CommandName for `guaka add`.".f.Red,
        "",
        "Call `guaka add CommandName` to create a new command.",
        ""
        ].joined(separator: "\n")

    case .commandAlreadyExist(let name, let path):
      return [ "The command `\(name)` already exist:".f.Red,
               "  \(path)".f.Red,
               "Please use a differnt command name"].joined(separator: "\n")

    case .wrongCommandNameFormat(let name):
      return [ "The command name passed `\(name)` is incorrect.".f.Red,
        "Please use only letters, numbers, underscodes and dashes.",
        "",
        "Valid examples:",
        "   guaka new test",
        "   guaka new MyCommand",
        "   guaka new my-command",
        "   guaka new my_command",
        "   guaka new myCommand"].joined(separator: "\n")

    case .tooManyArgsPassed:
      return "Too many arguments passed to command.".f.Red

    }

  }
}
