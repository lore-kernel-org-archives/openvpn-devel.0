MIME-Version: 1.0
In-Reply-To: <CAKuzo_iLEydt1py69+r1Fr+ba5JzVEPLMNq-53qxr4B-3CwVHw@...278...>
References: <b7d9be2a-b8e1-e565-198f-a5177e11d0c2@...1435...>
	<CAA1AbxK+mE0mz01UwrJ=o_6HBkBBe+FUXNnmqsfMe7vQLzCTsQ@...278...>
	<CAKuzo_iLEydt1py69+r1Fr+ba5JzVEPLMNq-53qxr4B-3CwVHw@...278...>
From: Steffan Karger <steffan@...1856...>
Date: Thu, 22 Sep 2016 22:42:26 +0200
Message-ID: <CAA1AbxKN6JUS4in3ZDS5zQjsNe2HRMmMv1MufW9fbj6sGCEKMw@...278...>
Subject: Re: [Openvpn-devel] Feature proposal: tls-crypt
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On 18 September 2016 at 22:07, Selva Nair <selva.nair@...277...> wrote:
> Does this mean that --tls-crypt will imply --tls-auth with the same key-file
> (or make the latter redudnant?). The man-page description in the patch
> appears to imply so, but not very clear..

--tls-crypt also includes authentication, and thereby makes --tls-auth
redundant.  --tls-crypt uses the same type of key as --tls-auth does.
I'll make that more clear in the docs.

-Steffan

