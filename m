Date: Tue, 28 Feb 2012 18:31:03 +0100
From: =?iso-8859-15?Q?Carsten_Kr=FCger?= <C.Krueger@...448...>
Message-ID: <1848924920.20120228183103@...449...>
In-Reply-To: <4F4CE4FE.3010009@...515...>
References: <4F4CE4FE.3010009@...515...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN 2.3-alpha1 released
Reply-To: =?iso-8859-15?Q?Carsten_Kr=FCger?= <C.Krueger@...448...>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: 

Hello Samuli,

> The OpenVPN community project team is proud to release OpenVPN
> 2.3-alpha1. It can be downloaded from here:

> <http://openvpn.net/index.php/open-source/downloads.html>

> This release includes a few new major features:

>  * Complete IPv6 support, both transport and payload
>  * Optional PolarSSL support (build time configuration)
>  * Improved plug-in API (v3) which can more easily be expanded in the
>    future: includes support for direct access to X.509 certificate data in
>    plug-ins
>  * Several improvements to the management interface
>  * One-to-one NAT to circumvent IP address conflicts between local and
>    remote networks
>  * New OpenVPN-GUI

Are there any chances to get full non-admin support for windows in version 2.3 final?

I mean strict seperation between OpenVPN service running with local system
privileges (can modify routes, etc.) and usermode part (command line, maybe GUI) that
interacts with user (start/stop tunnel, ask for passphrase, pin for smartcard, etc.).

In companies that have security in mind it's impossible to allow
roadwarriors to connect via openvpn because they would need admin
privileges.
Give them only the privilege to start/stop the openvpn service didn't help because they can't supply credentials.

I'm complaining about this show stoppper for ~4 years :-(

I personally like openvpn very much and would like to deploy it for
our users but I've to buy Cisco because the windows client is better.

greetings
Carsten


