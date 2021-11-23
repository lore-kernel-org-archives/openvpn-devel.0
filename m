MIME-Version: 1.0
References: <YZf4ch72IZYhz5Tb@...1296...>
 <BF86C1C6-216E-4D87-9D88-B5D03F84159D@...277...>
 <CAKuzo_hrpBxCT8NDosi9AbMKFCpGkCF-cE_qYVtuL3Nh-C-pCw@...278...>
 <CAGyAFMUHqDObKdOPD37T-Qau+CXyb-oCQu-NLHYtJKnwhse80g@...278...>
 <CAKuzo_hv8H6zRbvCx_g680TNhHEvoP=OvB_FbGOZAy=jmHvPvQ@...278...>
 <CAGyAFMXpBRGHsTZQjRsr2ByoGx2G2isoqUwaZnwYX6NWWwZBpA@...278...>
 <CAKuzo_ggddGKgDewDWbjv3pNGAC-SK0dmD+Ay-c2HOHcVX5psA@...278...>
 <YZwNiBRC+V/E9OeI@...1296...>
 <CAKuzo_jicUu50x-CxGYE2DJjW0pwf06DCfMkhFn5vKz1AHCrcA@...278...>
 <YZyPoyofdC4M1CqU@...1296...>
In-Reply-To: <YZyPoyofdC4M1CqU@...1296...>
From: Lev Stipakov <lstipakov@...277...>
Date: Tue, 23 Nov 2021 12:19:07 +0200
Message-ID: <CAGyAFMXE61tbhW=74jvoQLwegU2SjbFi8V-5JFGcEgO5=7OK2w@...278...>
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
Cc: Selva Nair <selva.nair@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

> I have no opinion on _putenv() vs. SetEnvironmentVariableW() - this is
> Windows API stuff, so whatever MS thinks we should be using...

SetEnvironmentVariableW() doesn't work for me with MSVC. Similar thing
with curl - openssl uses getenv, which
doesn't find variables added after the program was started:
https://github.com/curl/curl/issues/4774#L39

How should we proceed? Do we define safe conf/engines/modules locations and

 1) build them into openssl with our own port, and
 2) use env variables for openvpn and openvpn-gui ?

-- 
-Lev

