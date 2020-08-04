from rest_framework.permissions import BasePermission, SAFE_METHODS


class IsVerified(BasePermission):
    def has_permission(self, request, view):
        return bool(request.user.is_verified)


class IsSupervisorOrReadOnly(BasePermission):
    def has_permission(self, request, view):
        return bool(request.user.is_supervisor or
                    request.method in SAFE_METHODS)


class IsWorkerOrReadOnly(BasePermission):
    def has_permission(self, request, view):
        return bool(not request.user.is_supervisor or
                    request.method in SAFE_METHODS)


class IsSupervisor(BasePermission):
    def has_permission(self, request, view):
        return bool(request.user.is_supervisor)
