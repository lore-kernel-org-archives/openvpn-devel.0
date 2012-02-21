MIME-Version: 1.0
In-Reply-To: <CAOBzU4OXrximvEQHD=5ULWDF4LH=C87OOx7mYKVrst72fLyEXQ@...278...>
References: <CAOBzU4PN6qDxf39+s4noXEiW8hNbDy-hkQWGSauBd3hX0pu2hw@...278...>
	<CAOazyz0f3sERwjZsf3Ts3Xu7CQqBEf_-_VdbUZ7TrzhLbmTEsg@...278...>
	<CAOBzU4M02rr2U0kT6F=5s=NAX58AnbJZ+QfO2fZTPGyNnR1+7Q@...278...>
	<CAOazyz1MKVbzzGPLdVNKzaUKuVUj11awdPVwCejDtf8zKjhW6A@...278...>
	<CAOBzU4PtoHi66QDaKuL6FX55cyccwgfS+0vZ4SOR3dBhNMMXKQ@...278...>
	<CAOazyz2yKB5+SSK1cjWWnVryKxoYvxJjpE39ZTv+6_fBKvFmpQ@...278...>
	<CAOazyz0MzDDGW=A9SnwW2z7HSXW7XMocAvtvr_qKvF65qjbZuA@...278...>
	<CAOBzU4MOLVY1-0D5TXEYzEy35CeM8U-RK5HKY7wW77fwuuvfNg@...278...>
	<CAOazyz3DXz4bfEhii2YHPUKa_jn+DcTbMSMFEsXBDxWZqsEiHg@...278...>
	<CAOBzU4OXrximvEQHD=5ULWDF4LH=C87OOx7mYKVrst72fLyEXQ@...278...>
Date: Tue, 21 Feb 2012 14:14:51 +0200
Message-ID: <CAOazyz2sHf1zSER1yPRmzWgnxzzpcViGs5XavcQ+Q8oyQ5Eodw@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 00/35] build revolution
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Frank de Brabander <debrabander@...277...>
Cc: openvpn-devel@lists.sourceforge.net

On Tue, Feb 21, 2012 at 1:52 PM, Frank de Brabander
<debrabander@...277...> wrote:
> The pkg-config website says it runs on OS X, so that shouldn't be the issue.
>
> But if pkg-config is required for the new build process, shouldn't
> configure test for a valid version of pkg-config early on? Now it
> either fails at the pkcs11 part of ./configure or with linking errors
> with openssl (if PKG_CONFIG=true) when pkg-config is not present.

Yes, it fails because different sets of features are used.
I tried to fix this without pkg-config need for openssl.
Can you please try the new tarball?
Now use PKG_CONFIG=false

Alon.

