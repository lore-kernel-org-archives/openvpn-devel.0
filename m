MIME-Version: 1.0
In-Reply-To: <10D3DB24A1C0914A865302B34132386CC85825@...1217...>
References: <10D3DB24A1C0914A865302B34132386CC85825@...1217...>
Date: Thu, 30 Apr 2009 21:59:09 +0300
Message-ID: <9e0cf0bf0904301159n54c450cbr21302f835e5a5a1a@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] About pkcs11, from spain
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: "Alvarez Calvo, Francisco Javier" <sist2@...1215...>, openvpn devel <openvpn-devel@lists.sourceforge.net>

Can you please try to make the 1024 key work with the new version?
Can you please provide the output of openvpn --show-pkcs11-ids?
Can you please make sure you put the serialized id within a single
quotes ('xxxxx').
Can you please provide the OpenVPN log while in --verb 255?

Thanks.

On 4/30/09, Alvarez Calvo, Francisco Javier
<sist2@...1215...> wrote:
>
>
>
>
> Hi Alon!
>
>
>
> Excuse my poor english.
>
>
>
> I have read many pages about pkcs11, but I decided to talk to you because
> I=E2=80=99m stuck. I will understand if you couldn=E2=80=99t help me.
>
>
>
> I work in a company that have an openvpn. Until now our cards had an
> encryption of 1024, but now the encryption is 2048. That wasn=E2=80=99t a=
 problem at
> first, but now with the version 2.1rc4 it doesn=E2=80=99t work, so we dec=
ided to use
> a prior version like 2.1rc15, but the problem is that no pkcs11-slot-type
> neither pkcs11-slot options exists.
>
>
>
> I=E2=80=99ve been trying to use the new version with the pkcs11-id option=
, but the
> serialized is imposible to read (it=E2=80=99s something like        Seria=
lized id:
> FNMT\x2DRCM/\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\=
x03/=C2=AB=C3=B1=E2=94=B4R\x60P\x16/FNMT\x2DRCM/827F0CAFE2=E2=80=A6).
> The CA is a official organism here in Spain.
>
>
>
> Until now I have used the Subject from the token 1 (only one cert), with =
the
> name and the id Number of each user on it (like        DN:
> /C=3DES/O=3DFNMT/OU=3DFNMT Clase 2 CA/OU=3D701002933/CN=3DNOMBRE ALVAREZ =
CALVO JAVIER
> - NIF 33678735Y) but now and after read many pages with your answers I
> haven=E2=80=99t got anything with the new version.
>
>
>
> I wonder about the possibility of use pkcs11-id-management, but I don=E2=
=80=99t
> understand the possibilities, and the use of the serialized-id mencioned
> required us to change all the CCD of the clients.
>
>
>
> This is the old configuration (2.1rc4) that doesn=E2=80=99t works with th=
e new cards
> with a 2048 bits encryption. Most clients are Windows XP.
>
> client
>
> dev tun
>
> proto udp
>
> remote x.x.x.x 6996
>
> remote y.y.y.y 6996
>
> resolv-retry infinite
>
> nobind
>
> persist-key
>
> persist-tun
>
> ca caslinux.cer
>
> ns-cert-type server
>
> tls-auth talinux.key 1
>
> comp-lzo
>
> verb 3
>
>
>
> # Silence repeating messages
>
> ;mute 20
>
> pkcs11-providers c:\\windows\\system32\\cryptoki.dll
>
> pkcs11-slot-type label
>
> pkcs11-slot "FNMT"
>
> pkcs11-id-type subject
>
> pkcs11-id "/C=3DES/O=3DFNMT/OU=3DFNMT Clase 2 CA/OU=3D500010113/CN=3DNOMB=
RE CASTRO
> MONTA\\xF1A GONZALO - NIF 35697032K"
>
> #route 10.232.20.0 255.255.255.0
>
>
>
>
>
>
>
> Many Thanks and congratules for your good job
>
> Sa=C3=BAdos
>
> ________________________________________________________
>  Francisco Javier =C3=81lvarez Calvo
>  Dpto. Unidade de Sistemas - Ext. 57559
>  E-mail: sist2@...1216...
> -------------------------------------------------------------------
>  Cixtec
>  Santiago de Compostela
> -------------------------------------------------------------------
>  http://www.cixtec.es
>  ________________________________________________________
>
> -----BEGIN PGP PUBLIC KEY BLOCK-----
>
> Version: GnuPG v1.4.7 (MingW32)
>
>
>
> mQGiBEkIJAwRBACymuLFY3OY889wgtUlcnjSZ3OHihyo8wEMeS/T/joeFOpg+MmQ
>
> Ab9ELl/luq7FxMy27ZbbTR9Dobj5FKuAkqxhb6i7nzFq5scyl4a0V/Jbn6eHLZsy
>
> B+LoNgKtI6N1JfIhmrqCeB7euPA6qBfJpVDrXORPxpGuPQg5KbQDfC2EAwCgnZNI
>
> 2At3oaN014DUVY7rK13K3BsD/iBhyz3h/vqZoOmPoYbO3MvaGPQ+5finp+ws4/d4
>
> 5nlm/JW5yh/GFIoVBMjHkZx+KFcorhUaT2M+r5Ef4cACj+ZFdwP+uB57QoRN6gF3
>
> Zv9P6ELsp2LDYs645t/jC5bbVq5rr7gGQNAbGgdYaV5LBY4yswPc9hAcOLF7BmG0
>
> diFTA/0eVq71crBf+RLbmyLufRGIZheJD71YJbad85KPMQEzO9uEQwdrEyVaE7DR
>
> xy4L4ZW+8bVgr/BwJS7TMzyN4Fl8BVQ7qXDrPbjQrkGuQNmoWbpq0fUCBs41aixm
>
> eVcLuD8lxhF1RCK/q48FmwkcdQkMKA94tPPtXEWubMFp98jOwbQzRnJhbmNpc2Nv
>
> IEphdmllciBBbHZhcmV6IENhbHZvIDxqYXZpYWNAeHVudGFlY28uZXM+iGAEExEC
>
> ACAFAkkIJAwCGyMGCwkIBwMCBBUCCAMEFgIDAQIeAQIXgAAKCRCopI3Sf/IwJ7Nz
>
> AJ4pW2Ni5FhF+nICFJDXGxBgzQgkCQCgiJy18vMnI2L2/9M16FpYS4STCB+5AQ0E
>
> SQgkDBAEAJUzP7QcCsg9xO5rRU8BioTFQIfz79gG+eSbzSKksqimS6IxtVm9Msgk
>
> jWOBZTU4yHJ/wMM0ytg3JInYbA9hC0SrazUFI4waLnULJeHZPdF/WEB15WPa+CA8
>
> z11X87JIm7emD/u6QDA9YsiLJXNvWjBmkmOTR7XX0z4dkZuWJ7J3AAMFA/9Ayzum
>
> R+6f9CVNI3sLS27aqxgeJidQT+PYr85HL0vtYHEN26qrGLKERX4H/cz54jBw5PMh
>
> A1q0lP72HbBMzB6QmLbZIzlKxASkIwNHdmjAs+VtAe3dgRBziHIdoojLNIpMcbQS
>
> 71Si2EZ7YVVOS5AjJoD3TluXzgYvxlj7p5bJxIhJBBgRAgAJBQJJCCQMAhsMAAoJ
>
> EKikjdJ/8jAnGBEAn17MYbtDdttNva4LsM/XdB1GMXXBAJsHtBWvXzC/1FiOs9bp
>
> 0Y/GgKO03A=3D=3D
>
> =3D3Wwu
>
> -----END PGP PUBLIC KEY BLOCK-----
>
>
>

