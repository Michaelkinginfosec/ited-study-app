import { CanActivate, ExecutionContext, Injectable, Logger, NotFoundException, UnauthorizedException } from "@nestjs/common";
import { JwtService } from "@nestjs/jwt";
import { Observable } from "rxjs";
import { Request } from "express";

@Injectable()
export class JWTUserGuard implements CanActivate {
    constructor(private jwtService: JwtService) { }
    canActivate(context: ExecutionContext): boolean | Promise<boolean> | Observable<boolean> {
        const request: Request = context.switchToHttp().getRequest();
        const token = this.extractTokenFromHeader(request);
        if (!token) {
            throw new UnauthorizedException('Invalid token')
        }

        try {
            const payload = this.jwtService.verify(token);
            if (!payload || !payload.userId) {
                throw new UnauthorizedException("Invalid user Token")
            }
            request.user = payload;
        } catch (e) {
            Logger.error((e.message));

            throw new UnauthorizedException('Invalid Token')
        }
        return true;


    }

    private extractTokenFromHeader(request: Request): string | undefined {
        return request.headers.authorization?.split(' ')[1];

    }

}

