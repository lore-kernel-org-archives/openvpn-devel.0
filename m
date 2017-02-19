References: <cover.1487368114.git.logout@...260...>
	<3b87d588-aad7-433d-f802-ea9f9f7a0a63@...1856...>
	<82c84d12-58b9-471c-1f0d-550fa5ade390@...2080...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <d491f979-fcbc-99d0-6ec4-ca6536d2c562@...1856...>
Date: Sun, 19 Feb 2017 16:09:13 +0100
MIME-Version: 1.0
In-Reply-To: <82c84d12-58b9-471c-1f0d-550fa5ade390@...2080...>
Subject: Re: [Openvpn-devel] [RFC PATCH v1 00/15] Add support for OpenSSL
 1.1.x
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net


On 19-02-17 15:58, David Sommerseth wrote:
> On 19/02/17 13:03, Steffan Karger wrote:
> 
>> As discussed in other threads, we do want to support building on RHEL6,
>> which is why we would prefer to be compatible with (patched) OpenSSL
>> 0.9.8.  I haven't tested anything yet, but looking at the patches this
>> might very well just work, or otherwise just needs some minor tweaking.
> 
> RHEL6 ships with OpenSSL 1.0.1e.  We don't need anything older for git
> master, and I would even argue release/2.4.
> 
> RHEL5 (which goes EOL by end of next month) ships with OpenSSL 0.9.8e.
> So I vote for ditching 0.9.8e now.

Oh, very good.  I messed up the versions again...

The other big long-term-support distro, SLES, does still ship and
support 0.9.8 in SELS11 until 2019 (2022 for extended support), but can
be updated to 1.0.1.

As far as I'm concerned, that is enough reason to only support OpenSSL
1.0.1+ for OpenVPN 2.4 (and newer).

-Steffan

