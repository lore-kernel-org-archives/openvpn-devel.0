Message-ID: <41B427AE.80000@...324...>
From: Stefan Engel <mail@...324...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] bugfix: SuSE handling in openvpn.spec
References: <41B0734E.3010105@...324...> <Pine.LNX.4.58.0412031302050.10000@...41...>
In-Reply-To: <Pine.LNX.4.58.0412031302050.10000@...41...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Mon Dec  6 01:35:03 2004
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: James Yonan <jim@...41...>
Cc: openvpn-users@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net

James Yonan wrote:
> 
> On Fri, 3 Dec 2004, Stefan Engel wrote:
> 
> 
>>Hi,
>>
>>there is a minor bug in openvpn.spec (v2.0_beta19). In the %files
>>section the init script is always taken from /etc/rc.d/init.d instead
>>of /etc/init.d in case of a SuSE distribution. This results in an
>>rpm build error on SuSE systems.
>>
>>The appended patch should fix this.
>>
>>Regards,
>>
>>Stefan
>>
> 
> 
> Does this patch deal correctly with SuSE 9.1/9.2 differences?
> 
> James
> 

SuSE 9.1 and SuSE 9.2 use the same location for storing init-scripts,
i.e. /etc/init.d. Whereas the rpm variable %{_initrddir} seems to be
broken in 9.1 (pointing to the wrong directory), this is fixed in 9.2.

Stefan

