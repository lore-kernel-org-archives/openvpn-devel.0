References: <280154CA-9468-429B-BCAC-DB632C0AFB32@...2127...>
	<20160509180427.GL53051@...1296...>
	<58D68395-BFC5-4D6F-91A3-4A973008EB37@...2127...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <5731141A.3000506@...2080...>
Date: Tue, 10 May 2016 00:50:02 +0200
MIME-Version: 1.0
In-Reply-To: <58D68395-BFC5-4D6F-91A3-4A973008EB37@...2127...>
Subject: Re: [Openvpn-devel] [PATCH] Prevent integration test timeout bc. of
 sudo
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: Jens Neuhalfen <openvpn-devel@...2127...>, Gert Doering <gert@...1296...>
Cc: openvpn-devel <Openvpn-devel@lists.sourceforge.net>

On 09/05/16 22:39, Jens Neuhalfen wrote:
> Hi Gert,
>=20
> [=E2=80=A6]
>=20
>>
>> Git isn't liking the way you send your patches - I'll apply it manually
>> (because it makes sense), but please take a look at "git send-email",
>> which will ensure that patches and mail headers, blank encoding, and
>> everything is perfect?
>>
>> If I try to feed your mail into "git am", it complains about
>>
>> Applying: Prevent integration test timeout bc. of sudo
>> fatal: corrupt patch at line 19
>> Patch failed at 0001 Prevent integration test timeout bc. of sudo
>>
>> - not sure what it is, but it's usually fixed by "git send-email"... tha=
nks.
>=20
> strange, I use "git format-patch". I guess that "git am=E2=80=9D gets con=
fused about the =E2=80=9Cduplicate" Subject/From/.. lines (mail header and =
patch header).

Generally MUAs are not trustworthy in how they process copy-pasted text.  E=
ach
MUA behaves differently and requires different tweaks.  In this case, I
believe it is the first 'From' line in your patch which confuses your Apple
Mail, which somehow gets prefixed with a '>'.

> I=E2=80=99ll switch to send-email

Thanks!  That's the most sane MUA for patches.  It does everything correctly
(at least for the git universe).


--=20
kind regards,

David Sommerseth

