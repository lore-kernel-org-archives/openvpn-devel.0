Message-ID: <4438D109.4090906@...75...>
From: Bernd Bartmann <Bernd.Bartmann@...75...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Bug in spec-file: init script is overwritten
References: <4436B9CF.3080202@...75...> <20060408223504.GA24390@...611...>
In-Reply-To: <20060408223504.GA24390@...611...>
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
Date: Sun Apr  9 02:18:01 2006
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Steven Pritchard <steve@...609...>
Cc: openvpn-devel@lists.sourceforge.net

Steven Pritchard wrote:
> On Fri, Apr 07, 2006 at 09:13:19PM +0200, Bernd Bartmann wrote:
> 
>>The openvpn .spec-file supplied in the source code archive does not 
>>specify "%config(noreplace)" for the init file, i.e. if you run "rpm 
>>-Uvh openvpn.rpm" and you have a modified init script it is simply 
>>overwritten without notice. I would expect that the rpm update operation 
>>either creates a openvpn.rpmsave or openvpn.rpmnew file.
> 
> 
> A quick grep through the Fedora Core and Extras spec files shows that
> most don't even mark their init scripts as %config, much less
> %config(noreplace).

I just took a look at the spec-files for daemons that are in the FC5 
core-updates released so far. ALL of them have %config set for the init 
script:

%config is set for named, smb, sendmail, spamassassin
%config(noreplace) is set for squid

Anyway it does not hurt to protect the init script against being 
overwritten.

Best regards,
Bernd.

