References: <CAKuzo_izpuBXtnXHq2=QfSOen8OY0np-Gy=0=wA23uuCq6Etew@...278...>
From: mike tancsa <mike@...1800...>
Message-ID: <b1ade983-0961-17b0-0312-3bcc169d0db2@...1800...>
Date: Fri, 30 Jul 2021 08:39:54 -0400
MIME-Version: 1.0
In-Reply-To: <CAKuzo_izpuBXtnXHq2=QfSOen8OY0np-Gy=0=wA23uuCq6Etew@...278...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] Adding RSA-PSS support in pkcs11-helper
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: Selva Nair <selva.nair@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>, "openvpn users list (openvpn-users@lists.sourceforge.net)" <openvpn-users@lists.sourceforge.net>, tincanteksup <tincanteksup@...277...>

Hi,

=C2=A0=C2=A0=C2=A0 Thanks, I finally got around to testing this with the cu=
rrent
version of OpenVPN from git and it works great on my
Aladin/SafeNet/Gemalto/Thales token (model 510x)

Would be great if this was part of the default build/distribution.

I can now get TLS1.3 working using the pkcs11 interface.

=C2=A0=C2=A0=C2=A0 ---Mike

On 5/2/2021 7:13 PM, Selva Nair wrote:
> Hi,
>
> Currently RSA-PSS signatures are handled in pkcs11-helper by asking
> the token to do raw RSA signature of data already padded by OpenSSL.
> Many new hardware tokens refuse to support this mode and require the
> padding to be done in hardware.
>
> For a recent user report see this thread:
> https://www.mail-archive.com/openvpn-users@lists.sourceforge.net/msg05732=
.html
> <https://www.mail-archive.com/openvpn-users@lists.sourceforge.net/msg0573=
2.html>
>
> Probably there are some related tickets on Trac too.
> =C2=A0
> In OpenVPN, we have a couple of options to fix this:
>
> (i) Use a different library like libp11 (for OpenSSL only).
> (ii) Extend pkcs11-helper
> (iii) Roll something new on our own :)
>
> After some thought, I have decided that extending pkcs11-helper may be
> the least painful approach ---=C2=A0not including the mental distress in
> getting code reviews and changes accepted. The "helper" has several
> features that we depend on and not readily available in alternatives.
>
> If anyone is interested in testing this, see
> https://github.com/selvanair/pkcs11-helper/releases/tag/pss-support
> <https://github.com/selvanair/pkcs11-helper/releases/tag/pss-support>
>
> Though I've opened a PR at
> https://github.com/OpenSC/pkcs11-helper/pull/31
> <https://github.com/OpenSC/pkcs11-helper/pull/31> , it's only an RFC
> and would likely require=C2=A0some iterations.
>
> Comments, suggestions for improvement, and test reports, are most welcome.
>
> Thanks,
>
> Selva
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel


