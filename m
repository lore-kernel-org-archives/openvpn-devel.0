MIME-Version: 1.0
Sender: sebastien.raveau@...277...
In-Reply-To: <4A6F634E.7020202@...1114...>
References: <4A5EFE61.3020100@...41...>
	<9e0cf0bf0907280118t14949a47o5bb1bdefbb0721f5@...278...>
	<3453b4110907280133n32070ed3rd93598fd1b64740e@...278...>
	<9e0cf0bf0907280218p25c081f7v203b4780309cb6b9@...278...>
	<4A6EFCFF.2090400@...1114...>
	<9e0cf0bf0907280650i3dabf036gc9e2f8c745823e15@...278...>
	<4A6F05B0.4020602@...1114...>
	<9e0cf0bf0907280720y45b629d5sd7fe3d2525811280@...278...>
	<3453b4110907281129x509c2bb1rbbfe4a817765e503@...278...>
	<4A6F634E.7020202@...1114...>
Date: Tue, 28 Jul 2009 23:22:09 +0200
Message-ID: <3453b4110907281422u4284faen6cd632e62f11cdf7@...278...>
From: Sebastien Raveau <sebastien.raveau@...1231...>
Subject: Re: [Openvpn-devel] OpenVPN 2.1_rc19 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: David Sommerseth <openvpn.list@...1114...>
Cc: Alon Bar-Lev <alon.barlev@...277...>, openvpn-devel@lists.sourceforge.net

Thanks for your support :-)


On Tue, Jul 28, 2009 at 10:45 PM, David
Sommerseth<openvpn.list@...1114...> wrote:
> If I understood Alon correctly, he also executes OpenVPN as a less
> privileged user, meaning that it is impossible to escape out of that
> user, as the saved UID/GID will be a unprivileged user. =A0But! =A0Chroot
> will in this setting be impossible, because only root can do chroot().

Indeed, thought of mentioning that in my mail but then forgot...

On a side note, once you have chroot'ed you have to give up root
privileges as soon as possible since there are tricks to get out of a
chroot jail (like opening "." as a file, chrooting again in a
subdirectory and from there calling fchdir with the file descriptor
you had on the parent directory: as chroots are/were not stackable,
you could get out of it like that). Maybe these tricks don't work
anymore, but who knows... I doubt anybody would have an OpenVPN config
with the "chroot" option but without the "user" one, but it's still
worth mentioning I guess :-)

> Sebastien, back to your patch. =A0There is one thing I've been thinking
> about today, regarding the --setcon parameter you introduce to the
> openvpn binary. =A0Why does this need to be a runtime parameter? =A0I can=
not
> imagine you want to run openvpn with different security context on the
> same box, or even the same Linux distro. =A0In my eyes, this would be a
> static value. =A0The SELinux context could be a compile time argument,
> IMHO, which just defines a constant/macro which is when calling
> setcon(). =A0Or is it something else I'm missing here?

Well... On the one hand supporting an argument has no cost code-wise,
on the other hand not offering this liberty might annoy some users. I
guess this is the same as with the "user" option, perhaps 99.9% of the
people will make OpenVPN run under a "openvpn" user, but some people
might find a use in being able to specify another UID... I myself have
used features in programs for which the manpage would state "we have
no idea why anybody would use this feature" but I needed it and was
very greatful that they had implemented it anyway.


> If SELinux is found during configure, it could use a hard coded context.

If I understand you correctly, that is, if you are suggesting that
OpenVPN should automatically apply a SELinux context if setcon() is
available... I'll have to disagree with you. Not that I reject the
idea of enforcing security measures by default, but because when you
google for "selinux howto", half of the first-page results are on how
to *disable* SELinux. Apparently not everybody likes it, and they have
a right to, so I believe we should not force it upon them :-)


Kind regards,

--=20
Sebastien Raveau

