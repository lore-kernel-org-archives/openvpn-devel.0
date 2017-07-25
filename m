References: <f7687ebf-a75f-095d-67ca-e32a5c4e53e7@...515...>
 <1500293278.28621.32.camel@...1866...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <b6adb528-5d31-fa7b-cd0c-e87b69e0854c@...515...>
Date: Tue, 25 Jul 2017 19:53:21 +0300
MIME-Version: 1.0
In-Reply-To: <1500293278.28621.32.camel@...1866...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] Windows installer with updated pkcs11-helper
 (1.22) available for testing
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
To: David Woodhouse <dwmw2@...1866...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On 17/07/2017 15:07, David Woodhouse wrote:
> On Fri, 2017-07-14 at 17:07 +0300, Samuli Sepp=C3=A4nen wrote:
>> Hi all,
>>
>> Those of you who use pkcs11 on Windows: could you please test this new
>> Windows installer:
>>
>>
>>
>> The previous installer(s) had pkcs11-helper 1.11. This one has 1.22, so
>> some regression testing would be good to have.
>=20
> Please include the pkcs11-helper patch from
> https://github.com/OpenSC/pkcs11-helper/pull/4 to make it support using
> RFC7512 PKCS#11 URIs to specify certificates/keys instead of its own
> non-standard identifiers.
>=20
> (It still accepts the old form, for compatibility).
>=20

I released the new Windows installer but without this patch. That said,
the patch/PR you linked to makes sense. Does the patch have an active
maintainer? If yes, then I propose is that we

- Fork OpenSC/pkcs11-helper to OpenVPN/pkcs11-helper
- Apply the patch to our fork
- Produce and publish our own pkcs11-helper tarballs
- Point openvpn-build to our tarballs
- Periodically rebase our fork with upstream

Thoughts?

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

