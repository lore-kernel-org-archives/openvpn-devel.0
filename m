Message-ID: <4E3F969E.9060900@...515...>
Date: Mon, 08 Aug 2011 10:56:14 +0300
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <1312714757-10317-1-git-send-email-beber@...1472...>	<430b86c89889b28e473dfed2fc3ae817@...1492...>	<20110807175142.GS8496@...1296...>	<20110807175624.GW12223@...1474...>
	<20110807181103.GV8496@...1296...>
	<4E3F91E1.4020606@...515...>
In-Reply-To: <4E3F91E1.4020606@...515...>
Subject: Re: [Openvpn-devel] Allow to fill Details tab for exe files
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
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Il 08/08/2011 10:36, Samuli Sepp=E4nen ha scritto:
>>>>  - if I read this right, it will only work for the autoconf / mingw ba=
sed
>>>>    build, but not for the msvc++ / python based build, right?  will it
>>>>    co-exist, or break the python build?
>>> I have to say that I didn't test with msvc++/python as I only use to
>>> cross compile applications. But if I read well the build process for
>>> msvc++/python it does not use autotools stuffs.
>> Indeed.  David / Samuli: how is the python Makefile built?  How does
>> this build system know which files to compile?
>>
>> gert
> The Python-based buildsystem gets the list of files to build from
> Makefile.am's openvpn_SOURCES section (see win/wb.py and
> win/msvc.mak.in). These patches should not affect it, but won't do it
> any good, either :). I'm unable to test building atm, as the Windows
> build computer is being migrated to a better server. When that's
> finished, I'll try building Bertrand's Git tree and report back.
>
> Bertrand: what kind of information goes to the "Details" fields?
>
Sorry, did not notice the fixed patch at first. Please ignore me :).

Samuli

