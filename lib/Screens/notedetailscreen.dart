import 'package:flutter/material.dart';
import 'package:notes/Widgets/appbar.dart';

class Notedetailscreen extends StatelessWidget {
  const Notedetailscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, "Note", Icons.edit, () {}),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            // add condition to check if image id there or not
            
            Container(
              width: MediaQuery.of(context).size.width * 0.3,
              height: MediaQuery.of(context).size.width * 0.3,
              color: Theme.of(context).textTheme.labelMedium!.color,
              child: Icon(Icons.image_outlined, size: 35),
            ),

            Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.width * 0.15,
              child: Text(
                "Title",
                style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).textTheme.bodyMedium!.color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    "(Paragraph 1:"
                    "In a world that moves at breakneck speed, there is something profoundly grounding about stepping away from screens and schedules to observe the simple beauty of nature. A walk through a quiet forest, for instance, can reset the mind in ways no digital distraction ever could. The rustling of leaves beneath your feet, the faint scent of pine in the air, and the golden shafts of sunlight piercing through the canopy all combine to create a sensory experience that invites reflection. It is in these moments, away from the chaos, that one begins to notice the intricate details often missed—the texture of tree bark, the gentle hum of insects, or the distant call of a bird hidden among the branches."
                    "Paragraph 2:"
                    "Nature has a rhythm that contrasts sharply with the artificial pace of modern life. While cities are defined by urgency, the natural world embraces patience. A river doesn’t rush without cause; it flows steadily, carving its path over years. Trees grow silently but with persistence, each ring in their trunks a testament to survival and change. Observing this calm, deliberate progress can remind us that not everything requires immediate results. Sometimes, the best things in life come with time, effort, and stillness. There is a quiet wisdom in letting go of the need for constant productivity and embracing the art of simply being."
                    "Paragraph 3:"
                    "People often underestimate the restorative power of solitude, especially when spent in natural surroundings. Solitude is not loneliness; it is a conscious decision to engage with the world more deeply, without external noise. In the hush of nature, thoughts become clearer. You begin to hear your own inner dialogue more distinctly, free from the opinions and expectations of others. This space for reflection can spark creativity, solve problems, and foster a sense of gratitude. Nature, in its raw and unscripted form, serves as both a mirror and a mentor, offering lessons without words, guidance without judgment."
                    "Paragraph 4:"
                    "Yet, despite its gifts, nature is often taken for granted. Forests fall to development, oceans choke on plastic, and wildlife dwindles as habitats disappear. The irony lies in how much we depend on the natural world—not just for physical survival, but for emotional and psychological well-being—yet continue to damage it for short-term gain. Real change begins with small actions: choosing reusable materials, supporting conservation efforts, and simply appreciating the green spaces around us. When people reconnect with nature on a personal level, they are more likely to protect it. Caring grows from connection."
                    "Paragraph 5:"
                    "In the end, the harmony found in nature reflects the kind of balance many seek in their own lives. It’s not about isolation or escaping responsibilities, but about finding a rhythm that allows for both effort and ease, sound and silence, motion and stillness. The more we attune ourselves to nature’s pace, the more we learn to live with intention rather than compulsion. Whether it's a walk in the woods, a moment beneath the stars, or listening to the rain against the window, these small, quiet experiences have the power to transform. In their stillness lies their strength.)",
                    style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).textTheme.bodyMedium!.color,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
