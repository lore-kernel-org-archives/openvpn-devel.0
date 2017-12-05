References: <20171203211654.1044-1-simon@...2293...>
 <201712041759.vB4HxJaT048678@...2054...>
 <99D61A626FDA8A4B90A270669121BE1085B4B134@...2294...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <58f2d393-0e3c-c4ec-1573-9ae58e420914@...515...>
Date: Tue, 5 Dec 2017 13:19:35 +0200
MIME-Version: 1.0
In-Reply-To: <99D61A626FDA8A4B90A270669121BE1085B4B134@...2294...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH applied] Re: openvpnserv: Add support
 for multi-instances
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
To: Simon Rozman <simon@...2293...>, Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Il 05/12/2017 13:01, Simon Rozman ha scritto:
> Hi,
>=20
>> I've done a bit of staring at the code as well, and it seems to make sen=
se (but
>> thanks to Selva for a thorough review and actually testing this :-) ).
>>
>> Given the interaction with EduVPN 2.4, and the fairly well localized cha=
nges, I
>> agree to Selva's suggestion of having it in 2.4 as well.
>>
>> Your patch has been applied to the master branch and release/2.4 branch.
>=20
> This is excellent. This allows the eduVPN to switch to official openvpnse=
rv.exe when 2.4.5 is released.
>=20
> Should we/I document how to setup secondary instance of Interactive servi=
ce?
> I am new here and I would appreciate some guidance where and how to docum=
ent it. Before I forget. ;)
>=20

Hi,

I think we should have that documentation somewhere. I think it would be
 of interest mostly to developers. What about creating a new text file
to the repository. For example:

  doc/interactive-service-notes.txt

Thoughts?

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

