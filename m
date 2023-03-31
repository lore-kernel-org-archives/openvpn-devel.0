Message-ID: <72e67311-dd5b-f86e-4921-6e7c84c73d1c@...1227...>
Date: Fri, 31 Mar 2023 15:48:23 +0200
MIME-Version: 1.0
References: <20230331132429.601635-1-frank@...2641...>
Content-Language: en-GB
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20230331132429.601635-1-frank@...2641...>
Subject: Re: [Openvpn-devel] [PATCH] doc: run rst2* with --strict to catch
 warnings
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Frank Lichtenheld <frank@...2641...>, openvpn-devel@lists.sourceforge.net

Am 31.03.23 um 15:24 schrieb Frank Lichtenheld:
> Basically -Werror for docutils.
> 
> Fix all issues raised by this. The following issue
> classes were reported:
> 
> Possible title underline, too short for the title.
> Treating it as ordinary text because it's so short.
> (:: at the start of the line directly below text,
> either add empty line of merge into : on previous line)
> 
> Enumerated list start value not ordinal-1
> (error in numbering)

Thanks. That helps catching these mistakes early.

Acked-By: Arne Schwabe <arne@...1227...>


