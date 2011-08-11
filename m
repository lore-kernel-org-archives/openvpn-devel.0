Message-ID: <4E440BA3.2050107@...515...>
Date: Thu, 11 Aug 2011 20:04:35 +0300
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <1312714757-10317-1-git-send-email-beber@...1472...>
	<4E43F614.2030800@...515...>
	<20110811154507.GA1438@...1493...>
In-Reply-To: <20110811154507.GA1438@...1493...>
Subject: Re: [Openvpn-devel] d Re:  Allow to fill Details tab for exe files
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
To: Bertrand Jacquin <beber@...1472...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Il 11/08/2011 18:45, Bertrand Jacquin ha scritto:
> D'ar yaou 11 a viz Eost 2011 e 17 eur 32, =AB Samuli Sepp=E4nen =BB he de=
us skrivet :
>>> Hi there,
>>>
>>> Here is a serie of patch to allow get a details properties tab filled on
>>> exe files using windres tool.
>>>
>>> [PATCH 1/4] WIN32: Check for windres tool
>>> [PATCH 2/4] Win32: Add OpenVPN RC file to add fill "Details" exe
>>> [PATCH 3/4] Win32: Fill "Details" properties for openvpn.exe
>>> [PATCH 4/4] Win32: Fill "Details" properties for openvpnserv.exe
>>>
>> I just tested these patches with the Python-based buildsystem and there
>> were no negative side-effects (=3Dbuild worked as intended).
> Is the intented feature is effective with that kind of build ?
>
No, the Python-based buildsystem will require some glue to embed the
resource files to executable with windres or similar. I'll check out how
easy that'd be.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


