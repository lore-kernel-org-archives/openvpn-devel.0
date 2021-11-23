MIME-Version: 1.0
References: <BF86C1C6-216E-4D87-9D88-B5D03F84159D@...277...>
 <CAKuzo_hrpBxCT8NDosi9AbMKFCpGkCF-cE_qYVtuL3Nh-C-pCw@...278...>
 <CAGyAFMUHqDObKdOPD37T-Qau+CXyb-oCQu-NLHYtJKnwhse80g@...278...>
 <CAKuzo_hv8H6zRbvCx_g680TNhHEvoP=OvB_FbGOZAy=jmHvPvQ@...278...>
 <CAGyAFMXpBRGHsTZQjRsr2ByoGx2G2isoqUwaZnwYX6NWWwZBpA@...278...>
 <CAKuzo_ggddGKgDewDWbjv3pNGAC-SK0dmD+Ay-c2HOHcVX5psA@...278...>
 <YZwNiBRC+V/E9OeI@...1296...>
 <CAKuzo_jicUu50x-CxGYE2DJjW0pwf06DCfMkhFn5vKz1AHCrcA@...278...>
 <YZyPoyofdC4M1CqU@...1296...>
 <CAGyAFMXE61tbhW=74jvoQLwegU2SjbFi8V-5JFGcEgO5=7OK2w@...278...>
 <YZzCbiezMd/zkrAO@...1296...>
In-Reply-To: <YZzCbiezMd/zkrAO@...1296...>
From: Lev Stipakov <lstipakov@...277...>
Date: Tue, 23 Nov 2021 13:39:16 +0200
Message-ID: <CAGyAFMXZ9OJQJXxkOm6qVDEN4a9ZiMufgX5FTF2Bg9GtHrq4hA@...278...>
Subject: Re: [Openvpn-devel] OpenSSL build on Windows: OPENSSLDIR and
 MODULESDIR
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

> Can our installer use "custom locations", like "install all our software
> to "d:\mystuff\openvpn\"?

Yes.

> In that case, built-in paths won't work well (as was pointed out in the PR, to my dismay).

We could use something like C:\Windows\System32\SSL ?

One could install Windows to a different drive, but the first line of defence
could be a path defined by env variables.

> >  2) use env variables for openvpn and openvpn-gui ?
>
> I think that this might be the most flexible and robust approach.

On startup we could read the installation path from
HKLM\SOFTWARE\OpenVPN and assume
something like <installation-path>\ssl\openssl.cnf ?

-- 
-Lev

