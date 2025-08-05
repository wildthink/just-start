// Code generated from Pkl module `Workspace`. DO NOT EDIT.
import PklSwift

public enum Workspace {}

extension Workspace {
    public struct Module: PklRegisteredType, Decodable, Hashable {
        public static var registeredIdentifier: String = "Workspace"

        public var name: AnyHashable?

        public var owner: AnyHashable?

        public var version: AnyHashable?

        public var Projects: AnyHashable?

        public var Packages: AnyHashable?

        public var ThirdParty: AnyHashable?

        public var Tools: AnyHashable?

        public init(
            name: AnyHashable?,
            owner: AnyHashable?,
            version: AnyHashable?,
            Projects: AnyHashable?,
            Packages: AnyHashable?,
            ThirdParty: AnyHashable?,
            Tools: AnyHashable?
        ) {
            self.name = name
            self.owner = owner
            self.version = version
            self.Projects = Projects
            self.Packages = Packages
            self.ThirdParty = ThirdParty
            self.Tools = Tools
        }

        public init(from decoder: Decoder) throws {
            let dec = try decoder.container(keyedBy: PklCodingKey.self)
            let name = try dec.decode(PklSwift.PklAny.self, forKey: PklCodingKey(string: "name")).value
            let owner = try dec.decode(PklSwift.PklAny.self, forKey: PklCodingKey(string: "owner")).value
            let version = try dec.decode(PklSwift.PklAny.self, forKey: PklCodingKey(string: "version")).value
            let Projects = try dec.decode(PklSwift.PklAny.self, forKey: PklCodingKey(string: "Projects")).value
            let Packages = try dec.decode(PklSwift.PklAny.self, forKey: PklCodingKey(string: "Packages")).value
            let ThirdParty = try dec.decode(PklSwift.PklAny.self, forKey: PklCodingKey(string: "ThirdParty")).value
            let Tools = try dec.decode(PklSwift.PklAny.self, forKey: PklCodingKey(string: "Tools")).value
            self = Module(name: name, owner: owner, version: version, Projects: Projects, Packages: Packages, ThirdParty: ThirdParty, Tools: Tools)
        }
    }

    public struct Repo: PklRegisteredType, Decodable, Hashable {
        public static var registeredIdentifier: String = "Workspace#Repo"

        public var name: String

        public var repo: String

        public var version: String?

        public var branch: String

        public var docs: String?

        public init(name: String, repo: String, version: String?, branch: String, docs: String?) {
            self.name = name
            self.repo = repo
            self.version = version
            self.branch = branch
            self.docs = docs
        }
    }

    public struct Tool: PklRegisteredType, Decodable, Hashable {
        public static var registeredIdentifier: String = "Workspace#Tool"

        public var name: String

        public var install: String

        public var docs: String?

        public init(name: String, install: String, docs: String?) {
            self.name = name
            self.install = install
            self.docs = docs
        }
    }

    /// Load the Pkl module at the given source and evaluate it into `Workspace.Module`.
    ///
    /// - Parameter source: The source of the Pkl module.
    public static func loadFrom(source: ModuleSource) async throws -> Workspace.Module {
        try await PklSwift.withEvaluator { evaluator in
            try await loadFrom(evaluator: evaluator, source: source)
        }
    }

    /// Load the Pkl module at the given source and evaluate it with the given evaluator into
    /// `Workspace.Module`.
    ///
    /// - Parameter evaluator: The evaluator to use for evaluation.
    /// - Parameter source: The module to evaluate.
    public static func loadFrom(
        evaluator: PklSwift.Evaluator,
        source: PklSwift.ModuleSource
    ) async throws -> Workspace.Module {
        try await evaluator.evaluateModule(source: source, as: Module.self)
    }
}