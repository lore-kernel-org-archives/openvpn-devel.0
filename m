References: <ec21d010-67a3-0ff1-3c2a-d5db08039e45@...277...>
	<20170327183502.GJ93896@...1296...>
	<CAKh=nwE-U4C6CVw+XpdBE1RXjG_VOYoT=UuJDAPs2AOFOoP+jw@...278...>
	<668fd081-d9b4-1727-f506-07395cf0b475@...1435...>
	<8c8a5600-0e9a-eb04-41de-33ebfdf36bfd@...2080...>
	<20170328122131.GV93896@...1296...>
	<131d865b-fd4d-0c8c-df75-eadc3fb4c658@...2080...>
	<20170328124704.GW93896@...1296...>
	<296b8d47-a05d-c4e5-1d87-1ffcff2166ca@...277...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <ac9bbf70-f1a3-78b5-5d88-62df26cd12b9@...1435...>
Date: Tue, 28 Mar 2017 15:08:32 +0200
MIME-Version: 1.0
In-Reply-To: <296b8d47-a05d-c4e5-1d87-1ffcff2166ca@...277...>
Subject: Re: [Openvpn-devel] building HEAD + openssl 1.1 api fails @
 "crypto.c:823:32: error: invalid application of ???sizeof??? to incomplete
 type ???cipher_ctx_t"
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On 28-03-17 15:02, debbie10t wrote:
> On 28/03/17 13:47, Gert Doering wrote:
>> We need to communicate better what might affect users in new versions, so
>> they can test and complain/adjust in time (like, the stricter CRL handling
>> in 2.4, and - obviously - the --tls-remote bit)
> 
> Suggestion: A Wiki Page detailing deprecation plans with dated targets.

We have Changes.rst for that:
https://github.com/OpenVPN/openvpn/blob/master/Changes.rst

Let's please keep this list on one location only, and I think
Changes.rst is the right place.

-Steffan


