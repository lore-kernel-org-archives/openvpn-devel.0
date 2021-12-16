Date: Thu, 16 Dec 2021 18:16:08 +0100 (CET)
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <512099266.1472890.1639674968820@...2642...>
In-Reply-To: <20211207170211.3275837-10-arne@...1227...>
References: <20211207170211.3275837-1-arne@...1227...>
 <20211207170211.3275837-10-arne@...1227...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 09/21] Rework occ link-mtu calculation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net



> Arne Schwabe <arne@...1227...> hat am 07.12.2021 18:01 geschrieben:
> 
>  
> Use the functions that directly compute the link mtu instead relying on the
> frame logic.

Is the assumption that the old and new version of the calc_options_string_link_mtu
functions should return the same values for the same configuration? I tried to
actually test that with the UT, but they work so differently that it is
difficult to adapt the test. So before going further down that rabbit hole I wanted to
ask whether there is any sense in that or whether it is okay if they differ in
the value calculated.

Regards,
--
Frank Lichtenheld

