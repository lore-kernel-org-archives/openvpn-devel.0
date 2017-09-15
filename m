References: <1505450463-459-1-git-send-email-selva.nair@...277...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <41521e18-121d-ebda-3ac9-044310599288@...1227...>
Date: Fri, 15 Sep 2017 17:44:56 +0200
MIME-Version: 1.0
In-Reply-To: <1505450463-459-1-git-send-email-selva.nair@...277...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Check whether in pull_mode before
 warning about previous connection blocks
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: selva.nair@...277..., openvpn-devel@lists.sourceforge.net

On 9/15/17 6:41 AM, selva.nair@...277... wrote:
> From: Selva Nair <selva.nair@...277...>
>
> Eliminate the confusing message that says "explicit-exit-notify is ignored by
> previous <connection> blocks" when the option is pushed.
> Reported by: Eike Lohmann e.lohmann@...1294...
> https://www.mail-archive.com/openvpn-users@lists.sourceforge.net/msg04052.html

The problem exists for all connection block options that are pushable.
We rather need to signal when options are pushed (or do a dirty
streq(file, [pushed-options]) and then only ignore the warning. The
warning is just bogus for pushed options.

Arne

