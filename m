References: <1476996158-5390-1-git-send-email-davids@...515...>
From: debbie10t <debbie10t@...277...>
Message-ID: <b76abfb0-7ed3-b0ee-61db-2dba94390e4e@...277...>
Date: Thu, 10 Nov 2016 01:11:49 +0000
MIME-Version: 1.0
In-Reply-To: <1476996158-5390-1-git-send-email-davids@...515...>
Subject: Re: [Openvpn-devel] [PATCH] systemd: Improve the systemd unit files
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net



On 20/10/16 21:42, David Sommerseth wrote:

>  [Service]
>  PrivateTmp=true
> +RuntimeDirectory=openvpn
> +RuntimeDirectoryMode=0710
> +WorkingDirectory=/etc/openvpn/server
> +ExecStart=/usr/sbin/openvpn --status %t/openvpn/server_%i-status.log --status-version 2 --suppress-timestamps --config %i.conf

--status appears to cause many problems, why is it specified here ?

Regards

