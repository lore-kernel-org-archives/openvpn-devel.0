Message-ID: <4A8C25D6.3060508@...41...>
Date: Wed, 19 Aug 2009 09:18:30 -0700
From: James Yonan <jim@...41...>
MIME-Version: 1.0
References: <3453b4110906280913v5351fb0ev96fc9ddbbcf8b5a5@...278...>
In-Reply-To: <3453b4110906280913v5351fb0ev96fc9ddbbcf8b5a5@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Post-initialization SELinux support for
 OpenVPN
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Sebastien Raveau <sebastien.raveau@...1231...>
Cc: openvpn-devel@lists.sourceforge.net

Sebastien Raveau wrote:
> Hi everybody!
> 
> 
> OpenVPN already has support for dropping privileges and confining
> itself to a directory *after* startup (thanks to calls like setgid,
> setuid and chroot) which makes for much better management than if you
> had to respectively start OpenVPN unprivileged and add the privileges
> it (only) needs during startup, or if you chroot'ed OpenVPN before
> startup and had to copy the necessary files in the confinement
> directory.
> 
> The very same problem occurs with SELinux policy enforcement: one can
> apply a policy before startup (such as the ready-to-use one provided
> by http://oss.tresys.com/projects/refpolicy/browser/trunk/policy/modules/services/openvpn.te)
> but it is waaaay too complicated, just because many rights have to be
> granted to OpenVPN during its initialization... or one can apply a
> very simple SELinux policy to OpenVPN when the only need left is
> basically network I/O operations.
> 
> The only downside to this is that, just like with setuid() and
> chroot(), OpenVPN has to call setcon() itself, which is why I am
> submitting this patch :-)
> 
> Please note that, while this patch does indeed bring a new dependency
> to libselinux in OpenVPN on Linux:
> * the feature will of course only be added if detected by ./configure
> * libselinux is so common now that even /bin/ls is linked against it
> on most Linux systems
> so OpenVPN should get SELinux support quite transparently ;-)

Sebastien,

This looks good...  Thanks for putting it together!

A couple things:

Can you adapt the patch to the OpenVPN 2.1 branch?

Can you modify the patch slightly so that no code is added unless #ifdef 
HAVE_SETCON is true?

Thanks,
James

