References: <96d637db-5213-9bd6-8628-a89bd755010d@...277...>
From: debbie10t <debbie10t@...277...>
Message-ID: <f55a40ec-830c-ce21-d096-c52738f6c2ff@...277...>
Date: Tue, 25 Apr 2017 13:11:19 +0100
MIME-Version: 1.0
In-Reply-To: <96d637db-5213-9bd6-8628-a89bd755010d@...277...>
Subject: Re: [Openvpn-devel] For Windows: DHCP Client dependency
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>



On 25/04/17 01:18, debbie10t wrote:
> Hi,
>
> generally, Openvpn on Windows is dependent on the "Windows DHCP Client
> service" .. if that Service is not started, is it possible for Openvpn
> to report a *specific* log message that: _DHCP_ has failed to assign an
> IP address to TAP Adapter ?
>
> thanks

Looking closer at the log, it turns out there is a specific message:

.. Initialization Sequence Completed With Errors
    ( See http://openvpn.net/faq.html#dhcpclientserv )

The link [eventually] leads to this:
https://community.openvpn.net/openvpn/wiki/259-tap-win32-adapter-is-not-coming-up-initialization-sequence-completed-with-errors

which is sufficient.
Thanks

