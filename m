From: Steven Pritchard <steve@...609...>
Subject: Re: [Openvpn-devel] Bug in spec-file: init script is overwritten
Message-ID: <20060408223504.GA24390@...611...>
References: <4436B9CF.3080202@...75...>
Mime-Version: 1.0
In-Reply-To: <4436B9CF.3080202@...75...>
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
Date: Sat Apr  8 15:36:02 2006
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: Bernd Bartmann <Bernd.Bartmann@...75...>
Cc: openvpn-devel@lists.sourceforge.net

On Fri, Apr 07, 2006 at 09:13:19PM +0200, Bernd Bartmann wrote:
> The openvpn .spec-file supplied in the source code archive does not 
> specify "%config(noreplace)" for the init file, i.e. if you run "rpm 
> -Uvh openvpn.rpm" and you have a modified init script it is simply 
> overwritten without notice. I would expect that the rpm update operation 
> either creates a openvpn.rpmsave or openvpn.rpmnew file.

A quick grep through the Fedora Core and Extras spec files shows that
most don't even mark their init scripts as %config, much less
%config(noreplace).

Steve
-- 
Steven Pritchard - K&S Pritchard Enterprises, Inc.
Email: steve@...610...             http://www.kspei.com/
Phone: (618)398-3000               Mobile: (618)567-7320

