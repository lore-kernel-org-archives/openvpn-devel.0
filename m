Message-ID: <521684EA.2030202@...1114...>
Date: Thu, 22 Aug 2013 23:38:50 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <51C77F12.1090802@...515...> <5210B1EB.7000409@...1227...>
	<20130821072739.GG16543@...1296...>
	<52147A34.7050406@...1227...>
In-Reply-To: <52147A34.7050406@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] TLS versioning
Reply-To: openvpn-users@lists.sourceforge.net
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
To: Arne Schwabe <arne@...1227...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, James Yonan <james@...515...>

On 21/08/13 10:28, Arne Schwabe wrote:
[...snip...]
> Well I am not really sure what is going on on the Tomato firmware. I
> build a OpenSSL 0.9.7e (0.9.7e-3sarge3 to be exact, might already have
> some fixes in it, Tomato has 0.9.8d) on amd64 + OpenVPN 2.2.2 and that
> worked against 2.4-master. Before backing out the change or adding a
> backward fix I would like to understand what the real problem here is.

<grumpy_maintainer tongue_in_cheek="1">

IIRC, we decided a long time ago that the oldest distro we would support is 
RHEL5.  That code base is really getting ancient these days, but it ships 
OpenSSL 0.9.8e.  So I think we should have that in mind.

However, I understand that some firmware "vendors" doesn't have the same 
"quick" turn-over as RHEL does.  So I think I would rather let these old 
firmwares run OpenVPN 2.0 or 2.1 and let them support their own ancient code 
base on their own.  We need to move forward and not cling to the old days forever.

After all, the community supports OpenVPN 2.2 (to some degree) and 2.3 (latest 
stable) currently.  And I wouldn't be surprised if we drop 2.2 when 2.4 sees 
the light of day.  In addition, I think we raised the minimum requirement in 
2.3 to use OpenSSL 0.9.7 or newer (see commit 9b33b5a4).  I would even say we 
should probably even raise that one to 0.9.8 in OpenVPN 2.4.

</grumpy_maintainer>


--
kind regards,

David Sommerseth

-- 

kind regards,

David Sommerseth

