Message-ID: <50161F87.50504@...1227...>
Date: Mon, 30 Jul 2012 07:45:43 +0200
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <1342009010-9735-1-git-send-email-heiko.hund@...1489...>
	<5008669B.9070408@...1114...>
In-Reply-To: <5008669B.9070408@...1114...>
Subject: Re: [Openvpn-devel] [PATCH] add option --management-query-proxy
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net

Am 19.07.12 21:57, schrieb David Sommerseth:
> On 11/07/12 14:16, Heiko Hund wrote:
>> Make openvpn query for proxy information through the
>> management interface. This allows GUIs to provide (automatically
>> detected) proxy information on a per connection basis.
>>
>> This new option supersedes the undocumented --http-proxy-fallback
>> option and puts the responsibilty for HTTP proxy fallback handling
>> to the GUI caring for such.
>>
>> Signed-off-by: Heiko Hund <heiko.hund@...1489...>
>> ---
>>  doc/management-notes.txt |   31 ++++++++
>>  doc/openvpn.8            |    6 ++
>>  src/openvpn/init.c       |  185 +++++++++++++++++++++-------------------------
>>  src/openvpn/manage.c     |   52 +++----------
>>  src/openvpn/manage.h     |   17 ++---
>>  src/openvpn/options.c    |  112 ++++------------------------
>>  src/openvpn/options.h    |   28 +------
>>  src/openvpn/proxy.c      |   15 ++++
>>  src/openvpn/proxy.h      |    3 +
>>  src/openvpn/syshead.h    |    6 +-
>>  10 files changed, 178 insertions(+), 277 deletions(-)
>>
> This patch got reviewed by James Yonan, but he never responded publicly to
> this list.  But it's applied to the master branch, as James said this made
> sense if it makes writing the GUI easier.
>

This patch somehow proxy connecting with a simple http-proxy xx yy
option. Openvpn just ignores the proxy and connects directly. On a quick
glance I could not determine what went wrong.

Arne


