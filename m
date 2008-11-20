From: "John" <jknappers-argentia@...160...>
Date: Thu, 20 Nov 2008 09:54:19 +0100
Message-ID: <gg38jt$hsc$1@...1062...>
References: <4900B783.5090102@...1146...><49018F8E.9080201@...1147...>	<49074664.9010307@...1146...><49083955.80903@...1147...>	<49083C3C.3040401@...1146...><49084017.7060306@...1147...>
	<49106CAE.2060902@...1146...> <491CA5BD.1010809@...41...>
Sender: news <news@...1062...>
Subject: Re: [Openvpn-devel] [Openvpn-users] --auth-user-pass-verify
	and--script-security
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net
Cc: openvpn-users@lists.sourceforge.net


"James Yonan" <jim@...41...> schreef in bericht 
news:491CA5BD.1010809@...1151...
>

> I totally agree with you that we should not be breaking the semantics
> for calling external programs, and it wasn't our intention to do so.
> Our original hope was that the security benefits of migrating from
> system() to execve() on unix and CreateProcess() on Windows could be
> done transparently.  But seeing that that's not the case, I would
> suggest that we offer the previous system() semantics as a deprecated
> option, using the syntax
>
>   script-security <level> <mode>
>
> where mode is "execve" by default, (which means to use execve() on unix
> family platforms or CreateProcess on Windows) or "system" which means to
> use system().
>
> This means that any OpenVPN config prior to 2.1_rc9 could continue to
> use system() by adding:
>
>   script-security 2 system
>
> OpenVPN would issue a warning about system() usage being deprecated, but
> would continue to use pre-2.1_rc9 external program calling semantics.
>
> Comments?
>
> James
>
>
Hello,

Now it's possible again the use external programs with the "depreciated" 
option 'script-security 3 system'. I can finally upgrade form 2.1rc7 to 
2.1rc15. But it's still not clear and I couldn't find what the correct new 
syntax would be.

So in my (Windows) clients I want to add a registry setting on connecting to 
remove that setting a disconnection
Until 2.1rc7 I used:
up regedit -s addsettings.reg
down regedit -s removesettings.reg

How would be the syntax to used with the default option 'script-security 3 
execve' be?

regards,

John








>
> -------------------------------------------------------------------------
> This SF.Net email is sponsored by the Moblin Your Move Developer's 
> challenge
> Build the coolest Linux based applications with Moblin SDK & win great 
> prizes
> Grand prize is a trip for two to an Open Source event anywhere in the 
> world
> http://moblin-contest.org/redirect.php?banner_id=100&url=/ 




