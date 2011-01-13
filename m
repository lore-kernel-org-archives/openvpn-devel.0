Message-ID: <4D2ED72D.6090609@...515...>
Date: Thu, 13 Jan 2011 12:42:53 +0200
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <4D2C3D0A.2060607@...1114...> <4D2E139D.8020809@...1147...>
	<1294865908.20986.1@...1207...>
In-Reply-To: <1294865908.20986.1@...1207...>
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN documentation
 (man	page) review
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
To: OpenVPN developers <openvpn-devel@lists.sourceforge.net>, OpenVPN List <openvpn-users@lists.sourceforge.net>


> On 01/12/2011 02:48:29 PM, Jan Just Keijser wrote:
>
>=20=20=20
>> As for the document format: if we want users to contribute then we=20
>> should not opt for a too-difficult format that users would have to
>> learn=20
>> before being able to contribute. Docbook and/or texinfo are nice for=20
>> Linux users but you'd scare away most Windows/Mac users.
>> What about plain simple OpenDoc (odf) ?
>>=20=20=20=20=20
>
> If you say so.  (It's not as if they haven't seen html,
> which is superficially similar to docbook/xml,
> or haven't they?)  But they could install and use lyx
> and get a full-gui experience.  They'll have to install
> something anyway if they want to use odf.
>
>=20=20=20
I think the most straightforward option for users would be to use the
Trac Wiki: this option was discussed in the #openvpn-devel a while back.
Trac is probably not the optimal tool from formatting perspective, but
I'm pretty sure it's easiest method to add or change content. Users
would only need to know some of Trac's wiki syntax without of having to
learn things such as:

- Git/version control basics
- Docbook/xml/man/roff/whatever syntax
- basics of patching
- how our development process works

I'm pretty sure there are many who are not familiar with any of the
above, but could still contribute to the documentation. We'd obviously
need to make sure that the wiki pages can be exported in some useful format.

Any thoughts?

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


