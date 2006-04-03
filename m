Message-ID: <4431F7C4.4030804@...41...>
From: James Yonan <jim@...41...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Possible security bug
References: <20060403102922.GB2617@...30...>
In-Reply-To: <20060403102922.GB2617@...30...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Mon Apr  3 21:37:02 2006
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: OpenVPN devel <openvpn-devel@lists.sourceforge.net>

Alberto,

By default, the OpenVPN client doesn't accept pushed options from the 
server unless "pull" or "client" is specified.  The idea is that once 
you agree to accept configuration info from the server, you are trusting 
(to a certain extent) in its integrity, so there are limits in how far 
the client can be protected against a server which successfully 
authenticates at the SSL/TLS level, but then turns out to be malicious.

But Hendrik has a point in that you might want that trust to be 
finer-grained -- you might want to accept routes pushed from a server, 
but not a setenv (which could potentially be abused).

The patch to remove setenv from the set of options which the client will 
accept from the server (when "pull" or "client" is specified is fairly 
simple.

Just go to the pull_permission_mask function in init.c and remove the 
OPT_P_SETENV flag from the mask.

James

Alberto Gonzalez Iniesta wrote:
> Hi all,
>
> I have just received the following bug report from the Debian Bug Track
> System:
>
> --
> From: Hendrik Weimer <hendrik@...595...>
>
> As described in http://www.osreviews.net/reviews/security/openvpn
> OpenVPN contains a security hole that allows a malicious VPN server to
> take over connected clients.
>
> OpenVPN allows to push environment variables to a client via 'push
> setenv ...'. Using LD_PRELOAD it is possible to run arbitrary code as
> root. The only prerequisite is that the attacker needs to control a
> file on the victim's computer, e.g. by returning a specially crafted
> document upon web access.
>
> A possible solution would be to prefix all pushed environment
> variables with something like 'OPENVPN_'.
> --
>
> What's your opinion on this?
>
> Thanks,
>
> Alberto
>
>   


