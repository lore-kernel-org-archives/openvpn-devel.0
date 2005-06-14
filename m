From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] Why must PAM library be dlopened?
In-Reply-To: <200506141314.54183.nomis80@...401...>
Message-ID: <Pine.LNX.4.58.0506142114190.4004@...41...>
References: <200506141234.50171.nomis80@...401...> <200506141314.54183.nomis80@...401...>
MIME-Version: 1.0
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
Date: Tue Jun 14 20:32:10 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Simon Perreault <nomis80@...401...>
Cc: openvpn-devel@lists.sourceforge.net

On Tue, 14 Jun 2005, Simon Perreault wrote:

> On Tuesday 14 June 2005 12:34, Simon Perreault wrote:
> > I am wondering why the PAM library is dlopened by the auth-pam plugin. Why
> > can't it simply be linked with it?
> 
> More specifically, why can't the attached patch be applied?

When I was writing the auth-pam plugin, I had problems dynamically linking
the plugin to PAM unless OpenVPN itself was also dynamically linked to PAM
(which I didn't want to do).  Remember that PAM itself is going to dlopen,
in turn, the actual PAM module.  Combining dlopen with dynamic linking has
got to be problematic when you are dealing with crosslinked dependencies.  
dlopening PAM from the plugin seemed to solve all the problems, and
followed the approach that others took when accessing PAM from dynamic
modules.

James


