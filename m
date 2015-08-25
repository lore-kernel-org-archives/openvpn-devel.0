References: <55DB4C39.9040105@...2010...>
	<CAD2Ti2975xFpu4FrozJgptc4nti3V7aXGebZGfnRS1ynTgaZyw@...278...>
From: Boris Lytochkin <lytboris@...2010...>
Message-ID: <55DC124F.8010903@...2010...>
Date: Tue, 25 Aug 2015 09:59:27 +0300
MIME-Version: 1.0
In-Reply-To: <CAD2Ti2975xFpu4FrozJgptc4nti3V7aXGebZGfnRS1ynTgaZyw@...278...>
Subject: Re: [Openvpn-devel] Log cert serial no if it is revoked
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: grarpamp <grarpamp@...277...>, openvpn-devel@lists.sourceforge.net

Hi.

I disagree.
And openssl crl disagrees with you too. There are no sha1 (or other) 
fingerprints there, serial numbers are stored there :)
As far as I understand in most of the cases where X509 is used for 
OpenVPN, single (mostly probable self-signed) CA is used for 
authentication so serial number should be sane enough to understand 
which is which.
Anyway, feel free to add sha1 (you name it) fingerprint additionally to 
my patch - more information on the cause of denial of connection the better.

On 25.08.2015 9:38, grarpamp wrote:
> On Mon, Aug 24, 2015 at 12:54 PM, Boris Lytochkin
> <lytboris@...2010...> wrote:
>> Log serial number of revoked certificate
>> In most of situations admin of OpenVPN server needs to know which particular
>> certificate is used by client.
> Cert serial numbers found in the wild are hardly unique (witness
> the Mozilla CA bundle), thus no one with a sane mind refers to them
> as identifiers, nor do libraries/apps use them for things like cert pinning,
> nor should people be encouraged to think they are unique (even though
> there may now be some spec for that, but history precedes). The only place
> they'd have meaning is as text string for the local issuer, but it's really just
> duplication of work.
> The sha1 (or better) fingerprint of the cert should be used instead.
>
> ------------------------------------------------------------------------------
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

-- 
Boris Lytochkin
Yandex NOC
+7 (495) 739 70 00 ext. 7671


