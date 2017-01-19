References: <3decc2ec-f8a3-cb6c-a33f-e7f6368dd1b3@...515...>
From: debbie10t <debbie10t@...277...>
Message-ID: <f1b1c4ec-989b-67ef-2c97-006bee3bea0b@...277...>
Date: Thu, 19 Jan 2017 20:46:01 +0000
MIME-Version: 1.0
In-Reply-To: <3decc2ec-f8a3-cb6c-a33f-e7f6368dd1b3@...515...>
Subject: Re: [Openvpn-devel] ASLR/DEP -enabled 2.4.0 Windows installer
 available
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net


On 18/01/17 07:48, Samuli Sepp=E4nen wrote:
> Hi,
>
> There's now a 2.4.0 Windows installer where all executables and
> libraries have ASLR/DEP enabled:
>
> <https://build.openvpn.net/downloads/temp/openvpn-install-2.4.0-I602-aslr=
-dep.exe>
> <https://community.openvpn.net/openvpn/ticket/325>
>
> I ran the installer through the Windows test suite and did not encounter
> any obvious issues.
>
> More testing would be welcome - especially on 32-bit Windows - before we
> make this the default.

I have tested this on Win10Pro x86_64 as server and concurrent client.
For 24 hours .. so far without error.

Task manager shows DEP enabled while Windows is configured for
DEP on Windows processes only but the machine has Hardware enabled DEP
and shows DEP for 2.4.0-i601 as well . so not a very good test.

I don't have a 32bit windows compatible with 2.4

Regards.

