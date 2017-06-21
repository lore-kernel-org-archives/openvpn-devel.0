References: <c129e755-6c9e-a35f-2958-84b44baa96f2@...515...>
	<CAEsd45RR25O+vw=70Q5ZXRc+nnw19t+gjtz4+yiuOMM350vgcg@...278...>
	<173d674815ccc3a42fc615dbebeb3b0a.squirrel@...2257...>
	<a36da645-f114-bbb8-7d28-c2357a76b77e@...515...>
From: Matthias Andree <matthias.andree@...68...>
Message-ID: <4c282920-56e5-975b-02fe-8d6257793171@...68...>
Date: Wed, 21 Jun 2017 18:48:26 +0200
MIME-Version: 1.0
In-Reply-To: <a36da645-f114-bbb8-7d28-c2357a76b77e@...515...>
Content-Language: de-DE
Subject: Re: [Openvpn-devel] OpenVPN 2.4.3 released (with security fixes)
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
To: openvpn-devel@lists.sourceforge.net

Am 21.06.2017 um 16:33 schrieb Samuli Sepp=C3=A4nen:
> On 21/06/2017 17:06, Simon Matter wrote:
>>> On Wed, Jun 21, 2017 at 6:47 AM, Samuli Sepp=C3=A4nen <samuli@...515...>
>>> wrote:
>>>> The OpenVPN community project team is proud to release OpenVPN 2.4.3. =
It
>>>> can be downloaded from here:
>>>>
>>>> <http://openvpn.net/index.php/open-source/downloads.html>
>>> Hi. Thanks for this release.
>>>
>>> Verifying the PGP signature on 2.3.17.tar.gz works fine (so did 2.4.2
>>> a few weeks ago), but trying to verify the signature on 2.4.3.tar.gz
>>> fails with:
>> I wanted to ask this during the 2.4.2 hickup but now I really ask because
>> there is confusion again with 2.4.3:
>>
>> Could you please add check sums of all release files so that one can
>> easily check to have the correct download. Even MD5 works better no check
>> sum :-)
>>
>> Regards,
>> Simon
>>
> Makes sense. I'll see if I could tackle that tomorrow.
>
> Meanwhile I added a test script which downloads every release file and
> verifies their signatures. I will run this script as part of the release
> process.

It makes no sense at all. Don't start that!

You already provide detached GnuPG signatures, which are better suited
for most purposes and incidentally also cover the "checksum" purpose.


