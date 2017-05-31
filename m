References: <1496177444-18373-1-git-send-email-steffan@...1856...>
	<29f51139-a525-fd92-0fe1-195d308d2924@...2080...>
From: Matthias Andree <matthias.andree@...68...>
Message-ID: <e90dc9b7-14af-0c85-e0b9-1371e04ed6a1@...68...>
Date: Wed, 31 May 2017 07:51:23 +0200
MIME-Version: 1.0
In-Reply-To: <29f51139-a525-fd92-0fe1-195d308d2924@...2080...>
Content-Language: de-DE
Subject: Re: [Openvpn-devel] [PATCH release/2.4] configure.ac: fix building
 against static openssl
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Am 31.05.2017 um 02:31 schrieb David Sommerseth:
>
> I do however vaguely remember someone mentioning some BSD distros still
> being on 0.9.8 ... or was it some other OS?  ... Anyhow, do we need to
> care for them?  This is release/2.4 we're talking about after all.

The oldest OpenSSL version in use a supported FreeBSD version is FreeBSD
10.3's OpenSSL 1.0.1.
I haven't looked at other BSDs.

