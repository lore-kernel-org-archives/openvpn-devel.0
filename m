MIME-Version: 1.0
In-Reply-To: <CAOazyz3DXz4bfEhii2YHPUKa_jn+DcTbMSMFEsXBDxWZqsEiHg@...278...>
References: <CAOBzU4PN6qDxf39+s4noXEiW8hNbDy-hkQWGSauBd3hX0pu2hw@...278...>
	<CAOazyz0f3sERwjZsf3Ts3Xu7CQqBEf_-_VdbUZ7TrzhLbmTEsg@...278...>
	<CAOBzU4M02rr2U0kT6F=5s=NAX58AnbJZ+QfO2fZTPGyNnR1+7Q@...278...>
	<CAOazyz1MKVbzzGPLdVNKzaUKuVUj11awdPVwCejDtf8zKjhW6A@...278...>
	<CAOBzU4PtoHi66QDaKuL6FX55cyccwgfS+0vZ4SOR3dBhNMMXKQ@...278...>
	<CAOazyz2yKB5+SSK1cjWWnVryKxoYvxJjpE39ZTv+6_fBKvFmpQ@...278...>
	<CAOazyz0MzDDGW=A9SnwW2z7HSXW7XMocAvtvr_qKvF65qjbZuA@...278...>
	<CAOBzU4MOLVY1-0D5TXEYzEy35CeM8U-RK5HKY7wW77fwuuvfNg@...278...>
	<CAOazyz3DXz4bfEhii2YHPUKa_jn+DcTbMSMFEsXBDxWZqsEiHg@...278...>
Date: Tue, 21 Feb 2012 12:52:24 +0100
Message-ID: <CAOBzU4OXrximvEQHD=5ULWDF4LH=C87OOx7mYKVrst72fLyEXQ@...278...>
From: Frank de Brabander <debrabander@...277...>
Subject: Re: [Openvpn-devel] [PATCH 00/35] build revolution
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
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

The pkg-config website says it runs on OS X, so that shouldn't be the issue.

But if pkg-config is required for the new build process, shouldn't
configure test for a valid version of pkg-config early on? Now it
either fails at the pkcs11 part of ./configure or with linking errors
with openssl (if PKG_CONFIG=3Dtrue) when pkg-config is not present.

Greetings,
Frank

Op 21 februari 2012 12:44 heeft Alon Bar-Lev <alon.barlev@...277...>
het volgende geschreven:
> On Tue, Feb 21, 2012 at 1:32 PM, Frank de Brabander
> <debrabander@...277...> wrote:
>> When I try to build like this, it seems to fail at linking to openssl
>> (OS X Lion).
>>
>> ./configure PKG_CONFIG=3Dtrue
>> make
>> mekboek:openvpn-2.x-master brabander$ ls /usr/lib/libcrypto.* /usr/lib/l=
ibssl.*
>> /usr/lib/libcrypto.0.9.7.dylib /usr/lib/libcrypto.0.9.8.dylib
>> /usr/lib/libcrypto.dylib =A0 =A0 =A0 /usr/lib/libssl.0.9.7.dylib
>> /usr/lib/libssl.0.9.8.dylib =A0 =A0/usr/lib/libssl.dylib
>
> I am sorry, but for now you will have to add:
> OPENSSL_CRYPTO_LIBS=3D"-lcrypto"
> OPENSSL_SSL_LIBS=3D"-lssl"
>
> I want to get this fixed, but before I do, are you sure you don't have
> pkg-config package for this OS?
> I searched and found that there is pkg-config.
> I don't want to revert to the old detection mechanism if you can
> simply use pkg-config...
>
> Alon.

