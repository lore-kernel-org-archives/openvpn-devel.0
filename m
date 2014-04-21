Message-ID: <535572D2.9090706@...515...>
Date: Mon, 21 Apr 2014 13:34:42 -0600
From: James Yonan <james@...515...>
MIME-Version: 1.0
References: <1398064204-26476-1-git-send-email-james@...515...>
	<53550214.9080607@...1227...>
In-Reply-To: <53550214.9080607@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 1/4] Added "remote-override" config
	directive.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

On 21/04/2014 05:33, Arne Schwabe wrote:
> On 21.04.2014 09:10, James Yonan wrote:
>> remote-override <alt-remote> -- replace the hostname in all remote
>> directives with alt-remote.
>>
> Just a question. How does remote-override differ from ip-remote-hint?
> Both options seem to have the same effect aside from very subtle
> differences. Perhaps we should add this as an alias for the already
> existing option.

They are different options.

ip-remote-hint is used when the app driving the client via management 
interface has already done a DNS lookup on the remote address, and wants 
to save the OpenVPN core from having to do a redundant lookup.

remote-override is used when the client UI has an option that allows the 
end user to override the default server address.  For example a UI might 
give the user a drop-down list of regions to connect to.  Since it is 
common in OpenVPN configs to have a list of many "remote" directives for 
failover, we needed a directive that would do a "search/replace" on the 
hostname component of each "remote" item.

That's different from the approach of ip-remote-hint which is designed 
to only provide a DNS resolution hint for the first "remote" item.

James

