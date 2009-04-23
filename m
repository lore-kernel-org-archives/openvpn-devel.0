MIME-Version: 1.0
In-Reply-To: <m3prf3sag3.fsf@...1213...>
References: <m3prf3sag3.fsf@...1213...>
Date: Thu, 23 Apr 2009 20:43:09 +0300
Message-ID: <9e0cf0bf0904231043x61f0776dm4b463b113fa5ff33@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] rc15 rpm spec glitches
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Aleksandar Ivanisevic <aleksandar@...1212...>
Cc: openvpn-devel@lists.sourceforge.net

I don't think this rpm is maintained, the rpm based distributions has
a different versions.

Alon.

On 4/23/09, Aleksandar Ivanisevic <aleksandar@...1212...> wrote:
> Hi,
>
>  I've been compiling a rpm of rc15 on rhel5 and noticed a couple of
>  glitches:
>
>  %doc lists management/ dir, but its no longer there, so
>
>  %doc contrib/ easy-rsa/ management/ sample-*/ plugin/README.*
>
>  should be
>
>  %doc contrib/ easy-rsa/ sample-*/ plugin/README.*
>
>  with_pkcs11 tries to pull in pkcs11-helper, but no such package exists
>  in RHEL, so it must be distro specific, but don't know which distro
>
>  %{!?with_pkcs11:BuildRequires: pkcs11-helper-devel}
>  %{!?with_pkcs11:Requires:      pkcs11-helper}
>
>  it builds fine with --nodeps though.
>
>  regards,
>
>
>  ------------------------------------------------------------------------------
>  Stay on top of everything new and different, both inside and
>  around Java (TM) technology - register by April 22, and save
>  $200 on the JavaOne (SM) conference, June 2-5, 2009, San Francisco.
>  300 plus technical and hands-on sessions. Register today.
>  Use priority code J9JMT32. http://p.sf.net/sfu/p
>  _______________________________________________
>  Openvpn-devel mailing list
>  Openvpn-devel@lists.sourceforge.net
>  https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

