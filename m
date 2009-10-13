Message-ID: <BLU0-SMTP378B17F1770F93AFB32A7FBBC70@...512...>
Date: Tue, 13 Oct 2009 20:28:12 +0200
From: The Zep Man <the_zep_man@...160...>
MIME-Version: 1.0
References: <BLU0-SMTP4766D046DAC27387E8F14BBC90@...512...>	<4AD494F3.30805@...41...>
	<BLU0-SMTP94F951A9B55CEC1F31E476BBC70@...512...>
	<4AD4C0BE.4090709@...1114...>
In-Reply-To: <4AD4C0BE.4090709@...1114...>
Subject: Re: [Openvpn-devel] Feature request: Client-side username/password
 retrieval using environment variables
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
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net

David Sommerseth wrote:
> Am I missing something here or?  openvpn does support this already, but
> I'm doing it via a C plug-in ...
> 
> <http://www.eurephia.net/doxygen/eurephia-devel/eurephia_8c_source.html#l00348>

In this case, the plug-in (which needs to be compiled) gets it from the 
environment, not OpenVPN itself.

> I haven't studied the openvpn code to see if this goes for the script
> interface ... but if it really is missing, it shouldn't be that hard to
> fix.  On the otherhand, if it is difficult, writing your own script
> runner as a plug-in is definitely not an impossible task.

Script runner?

My idea is to let OpenVPN (vanilla) grab a username and password from 
the environment for client-side authentication (if allowed/specified 
by/in the configuration). This method for username and password 
insertion doesn't need any third-party patches or OS-specific scripts to 
work.

Regards,

Zep


