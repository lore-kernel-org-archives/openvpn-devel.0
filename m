Message-ID: <5109B1DA.2050001@...1114...>
Date: Thu, 31 Jan 2013 00:50:50 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <20130130130717.GB19096@...1805...>
In-Reply-To: <20130130130717.GB19096@...1805...>
Subject: Re: [Openvpn-devel] [PATCH] x509 validity for tls-verify
Reply-To: "openvpn-devel@lists.sourceforge.net"
	<openvpn-devel@lists.sourceforge.net>
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
To: Emmanuel Dreyfus <manu@...1031...>
Cc: openvpn-devel@lists.sourceforge.net

On 30/01/13 14:07, Emmanuel Dreyfus wrote:
> Hi
>
> Please consider the attached patch that makes x509 xertificate validity
> (notBeofre and notAfter) available in environement for the tls-verify
> script.
>
> I use it to monitor OpenVPN certificate expirations in Nagios. I can
> share the Nagios bits with whoever is interested.

Thank you very much for your patch.  Just a few comments.  Gert already 
covered the PolarSSL part.  I think we should have PolarSSL support included 
as well when pulling in new code which depends on this.  Simply to avoid those 
to implementation to divert too much.

Another thing is that we are exporting quite a large set of environment 
variables already and we should probably rather reduce that footprint than 
increasing it further.  In addition, considering that the v3 plug-in API 
already exports the complete certificate in a native format used by SSL 
library, wouldn't it make more sense to rather put this functionality into a 
plugin directly?

For a simple example, have a look at sample/sample-plugins/log/log_v3.c


-- 
kind regards,

David Sommerseth

