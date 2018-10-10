References: <1539154306-27462-1-git-send-email-steffan.karger@...1435...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <da4b3a76-7137-c91a-d717-bda78eb6c3e9@...1435...>
Date: Wed, 10 Oct 2018 09:05:15 +0200
MIME-Version: 1.0
In-Reply-To: <1539154306-27462-1-git-send-email-steffan.karger@...1435...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Remove example unit tests
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

[ Talking to myself here... ]

On 10-10-18 08:51, Steffan Karger wrote:
> We have plenty real unit test that can be used as examples, so the
> example tests are no longer needed. Let's get rid of them.
NAK.  The patch is wrong because it leaves around a trace of the example
tests in configure.ac, doesn't update the README in tests/unit_tests/
and the examples actually still are useful as a template.

So on second thought I think it's better to just leave them in.

-Steffan

