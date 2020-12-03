References: <20200616180046.8069-1-juliusz@...2525...>
 <c926d584-471b-c66e-21f8-4c31410b5e4f@...2525...>
 <4f5787ef-fa03-f7d1-db9a-52fe61caf281@...1227...>
 <4cb6ea57-4dd1-8230-cec4-d4e8f434944b@...2525...>
 <5b5bd12b-d2a0-8901-1a0e-4ba7b3e5f7d0@...1227...>
 <9630aa71-2ba0-879a-3345-85a9551cd169@...2525...>
 <1e682031-8b10-7beb-1379-b32535f40de8@...1227...>
 <1998772f-b476-1862-9102-b95fd1a33be7@...2525...>
 <8e766bf2-a64e-63de-c69d-e899d2a11165@...1227...>
 <50c23608-1b71-1651-fa4e-af0d39aba7b3@...2525...>
 <0f47e3c7-f9d2-1649-0fb7-b0b58fa4b84a@...1227...>
 <37a8a66a-bc0f-a9a8-4e83-a991d80a359c@...2525...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <b810f56f-e7c2-22af-5744-bfea06d1b477@...1227...>
Date: Thu, 3 Dec 2020 15:22:52 +0100
MIME-Version: 1.0
In-Reply-To: <37a8a66a-bc0f-a9a8-4e83-a991d80a359c@...2525...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH] Support for wolfSSL in OpenVPN
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
To: Juliusz Sosinowicz <juliusz@...2525...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 03.12.20 um 14:32 schrieb Juliusz Sosinowicz:
> Hi Arne,
> 
> I didn't send a new patch yet because I only wanted to provide an update
> that progress is being made. I'm attaching an updated patch if you are
> interested.
> 
> I didn't get that error when compiling wolfSSL with the compile options
> you provided. Is it possible that you didn't run `autoreconf` after
> pulling in the latest commit in the branch but before running the
> configure script?

Yes. The -Wshorten-64-to-32 might be Clang/LLVM specific or not enabled
on gcc by default.

> 
> The warning is due to wolfSSL using a generic compare function
> definition with pointers to void as parameters.

Yeah, it breaks -Werror which I normally use to compile OpenVPN.

Arne


