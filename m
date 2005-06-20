From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] Why must PAM library be dlopened?
In-Reply-To: <200506141314.54183.nomis80@...401...>
Message-ID: <Pine.LNX.4.58.0506202032420.10675@...41...>
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
Date: Mon Jun 20 19:43:12 2005
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

When I apply your patch and run on SuSE 9.1 with the default "login" PAM 
module (pam-0.77-221):

  plugin openvpn-auth-pam.so "login login USERNAME password PASSWORD"

I get:

  AUTH-PAM: BACKGROUND: user 'x' failed to authenticate: Module is unknown

Without the patch, the same test runs fine.

James


