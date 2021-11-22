MIME-Version: 1.0
References: <YZf4ch72IZYhz5Tb@...1296...>
 <BF86C1C6-216E-4D87-9D88-B5D03F84159D@...277...>
 <CAKuzo_hrpBxCT8NDosi9AbMKFCpGkCF-cE_qYVtuL3Nh-C-pCw@...278...>
 <CAGyAFMUHqDObKdOPD37T-Qau+CXyb-oCQu-NLHYtJKnwhse80g@...278...>
 <CAKuzo_hv8H6zRbvCx_g680TNhHEvoP=OvB_FbGOZAy=jmHvPvQ@...278...>
In-Reply-To: <CAKuzo_hv8H6zRbvCx_g680TNhHEvoP=OvB_FbGOZAy=jmHvPvQ@...278...>
From: Lev Stipakov <lstipakov@...277...>
Date: Mon, 22 Nov 2021 22:26:47 +0200
Message-ID: <CAGyAFMXpBRGHsTZQjRsr2ByoGx2G2isoqUwaZnwYX6NWWwZBpA@...278...>
Subject: Re: [Openvpn-devel] OpenSSL build on Windows: OPENSSLDIR and
 MODULESDIR
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Selva Nair <selva.nair@...277...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

I added

    _putenv("OPENSSL_CONF=3Dc:\\Temp\\lol.conf");

to openvpn_main() and see

    22:01:38,9512311 openvpn.exe 27668 CreateFile C:\Temp\lol.conf
NAME NOT FOUND

in procmon. So would it be enough to set config/engines/modules paths
as env variables for openvpn and gui? OTOH we also ship openssl.exe,
which is used by easyrsa?

ma 22. marrask. 2021 klo 19.56 Selva Nair (selva.nair@...277...) kirjoitti:
>
> Hi,
>
> On Mon, Nov 22, 2021 at 12:20 PM Lev Stipakov <lstipakov@...277...> wrote:
>>
>> I added a commit to vcpkg/openssl PR
>> (https://github.com/microsoft/vcpkg/pull/21540) which gives an option
>> to customize ENGINESDIR. Unfortunately openssl doesn't make it easy -
>> ENGINESDIR is built based on --prefix, which is set to vcpkg build
>> dir. The prefix cannot be set to something like C:\SSL, because in
>> this case vcpkg build would require an elevated prompt. So I had to
>> patch the makefile template. Let's see if there are less hacky ways to
>> do it.
>
>
> A common practice for locally installing to a private path for developmen=
t would be to do a "prefix relocation" using DESTDIR:
>
> make DESTDIR=3D/home/selva/openssl-pkg/ install
>
> which will preserve the search paths compiled into the library. This will=
 work for cross-compile on linux even with drive letters in prefix, though =
awkward.  But such an approach cannot work on Windows as "C:" cannot be emb=
edded in Windows paths.
>
> A hack could be to use paths without a drive letter: like prefix =3D "/Pr=
ogram Files/OpenVPN/" etc. and then use DESTDIR to relocate for the develop=
ment installation. That relies on the Windows behaviour that paths starting=
 with "/" resolve to "C:/"  and depends on the value of "current drive" whi=
ch is probably reliable.
>
> Otherwise patching as you propose may be the only way..
>
> That said, how safe is this use of "C:/Program files/foo-bar" itself? Cou=
ld it be vulnerable in localized Windows -- e.g., "C:/Program Files/" may n=
ot exist in some language versions and any user could then create one. If s=
o, we may have to set "C:/Windows/System32/" or some such path as OPENSSLDI=
R, ENGINESDIR and MODULESDIR. It's unfortunate that OpenSSL folks decided t=
o use hard-coded values in the library for config location and dll search p=
aths.
>
> Given these difficulties, shall we (also) set env vars in OpenVPN.exe on =
startup so that OpenSSL config file and search paths will point to safe loc=
ations determined at run time (only if not already set by user) -- needed o=
nly for Windows as we do not distribute OpenSSL for other platforms. OpenSS=
L docs say what env vars are used to override built-in paths, I'll do some =
tests to be sure.
>
> Selva



--
-Lev

