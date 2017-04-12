References: <20170411173133.18060-1-davids@...515...>
	<429bda10-5a65-785f-661e-f4ae2708349f@...1435...>
	<050f70e9-1558-a354-ea36-8b786f0af086@...2080...>
From: Matthias Andree <matthias.andree@...68...>
Message-ID: <dd084b32-6e96-b9d0-9477-9fcff9c4a7df@...68...>
Date: Wed, 12 Apr 2017 03:06:02 +0200
MIME-Version: 1.0
In-Reply-To: <050f70e9-1558-a354-ea36-8b786f0af086@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Require minimum OpenSSL 1.0.1
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Am 11.04.2017 um 23:56 schrieb David Sommerseth:
> On 11/04/17 23:20, Steffan Karger wrote:
>> For release/2.4: I wonder whether we need to keep 0.9.8 support, as
>> SLES11 still ships with 0.9.8h, and has general support until 31 Mar 201=
9.
> While it is James who insisted on RHEL being the oldest supported distro
> many years ago, I have no issues with keeping SLES *or* RHEL as the
> oldest supported distro, in regards to package dependencies.
>
> Do we know if we have a large group of SLES 11 users?  Initially I
> thought it was related to OpenVPN-NL ... until I recalled that
> OPenVPN-NL should be built against mbed TLS :)

How many of the enterprise users will want to update and then can't be
bothered to install a newer OpenSSL into /opt?
Older OpenSSL versions are EOL, I don't think the community edition
should waste any energy on support such stuff. I'd even discontinue
1.0.1 support on master for the same reason because 1.0.1 is also past
the end of its life.


